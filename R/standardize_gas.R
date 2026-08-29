#' Normalize a gas name for matching
#'
#' Collapses case, whitespace, hyphens, and underscores so that variants like
#' `"HFC-134a"`, `"hfc134a"`, and `"HFC 134a"` compare equal.
#'
#' @param x Character vector.
#' @return Character vector of normalized keys.
#' @keywords internal
normalize_key <- function(x) {
  x |>
    stringr::str_to_lower() |>
    stringr::str_remove_all("[\\s\\-_]")
}

#' Standardize a gas name to its canonical `gas_id`
#'
#' Matches input names against `gases$gas_id` first, then against
#' `gas_synonyms$synonym`, using a normalized (case/whitespace/hyphen
#' insensitive) comparison. No fuzzy matching is performed - an unmatched
#' name returns `NA`, it is never guessed at.
#'
#' @param x Character vector of gas names as they appear in your data.
#'
#' @return A tibble with columns `input`, `gas_id` (`NA` if unmatched), and
#'   `match_type` (`"gas_id"`, `"synonym"`, or `"unmatched"`).
#'
#' @examples
#' standardize_gas(c("HFC-134a", "R-134a", "not a real gas"))
#'
#' @export
standardize_gas <- function(x) {
  key <- normalize_key(x)

  gas_id_lookup <- co2e::gases |>
    dplyr::transmute(
      key = normalize_key(.data$gas_id), .data$gas_id, match_type = "gas_id"
    )

  synonym_lookup <- co2e::gas_synonyms |>
    dplyr::transmute(
      key = normalize_key(.data$synonym), .data$gas_id, match_type = "synonym"
    )

  # gas_id matches take priority over synonym matches for the same key
  combined_lookup <- dplyr::bind_rows(gas_id_lookup, synonym_lookup) |>
    dplyr::distinct(.data$key, .keep_all = TRUE)

  tibble::tibble(input = x, key = key) |>
    dplyr::left_join(combined_lookup, by = "key") |>
    dplyr::mutate(
      match_type = dplyr::if_else(
        is.na(.data$match_type), "unmatched", .data$match_type
      )
    ) |>
    dplyr::select("input", "gas_id", "match_type")
}

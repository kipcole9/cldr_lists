defmodule Cldr.List.Test do
  use ExUnit.Case
  alias Cldr.List

  describe "to_string/2" do
    test "that three element lists format correctly" do
      assert List.to_string([1, 2, 3], TestBackend.Cldr) == {:ok, "1, 2, and 3"}
    end

    test "that two element lists format correctly" do
      assert List.to_string([1, 2], TestBackend.Cldr) == {:ok, "1 and 2"}
    end

    test "that one element lists format correctly" do
      assert List.to_string([1], TestBackend.Cldr) == {:ok, "1"}
    end

    test "that empty lists format correctly" do
      assert List.to_string([], TestBackend.Cldr) == {:ok, ""}
    end

    test "a bad format returns an error" do
      assert List.to_string([1, 2, 3], TestBackend.Cldr, format: :jabberwocky) ==
               {:error,
                {Cldr.UnknownFormatError, "The list format style :jabberwocky is not known."}}
    end

    test "a bad locale returns an error" do
      assert List.to_string([1, 2, 3], TestBackend.Cldr, locale: "nothing") ==
               {:error, {Cldr.UnknownLocaleError, "The locale \"nothing\" is not known."}}
    end

    test "that an invalid format raises" do
      assert_raise Cldr.UnknownFormatError, fn ->
        List.to_string!([1, 2, 3], TestBackend.Cldr, format: :jabberwocky)
      end
    end
  end

  describe "intersperse/2" do
    test "that three element lists format correctly" do
      assert List.intersperse([1, 2, 3], TestBackend.Cldr) == {:ok, [1, ", ", 2, ", and ", 3]}
    end

    test "that two element lists format correctly" do
      assert List.intersperse([1, 2], TestBackend.Cldr) == {:ok, [1, " and ", 2]}
    end

    test "that one element lists format correctly" do
      assert List.intersperse([1], TestBackend.Cldr) == {:ok, [1]}
    end

    test "that empty lists format correctly" do
      assert List.intersperse([], TestBackend.Cldr) == {:ok, []}
    end

    test "a bad format returns an error" do
      assert List.intersperse([1, 2, 3], TestBackend.Cldr, format: :jabberwocky) ==
               {:error,
                {Cldr.UnknownFormatError, "The list format style :jabberwocky is not known."}}
    end

    test "a bad locale returns an error" do
      assert List.intersperse([1, 2, 3], TestBackend.Cldr, locale: "nothing") ==
               {:error, {Cldr.UnknownLocaleError, "The locale \"nothing\" is not known."}}
    end

    test "that an invalid format raises" do
      assert_raise Cldr.UnknownFormatError, fn ->
        List.intersperse!([1, 2, 3], TestBackend.Cldr, format: :jabberwocky)
      end
    end
  end
end

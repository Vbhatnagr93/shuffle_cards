 defmodule Cards do   #most code is written in modules which is a collection of methods or functions

    @moduledoc """
      Provides methods for creating and handling a deck of cards
    """


    @doc """
    returns a deck of strings representing playing cards
    """

    def create_deck do        # New method inside our module
      values = ["Ace", "Two", "Three", "Four", "Five"]   # implicitly returned
      suits = ["Spades", "Clubs", "Hearts", "Diamond"]


      for suit <- suits, value <- values do #For every element in Suits, do something
        "#{value} of #{suit}"
      end
      #List.flatten(cards) #Removes collection of arrays and displays as one big array
   end

   def shuffle(deck) do #Arg to a method
     Enum.shuffle(deck) #Enum is for when you're working a list of data
   end

   def contains?(deck, card) do #Cards.contains?(deck, "two")
     Enum.member?(deck, card)
   end

   @doc """
      Divides a deck into a hand and the remainder of the deck.
      The `hand_size` argument indicates how many cards should be in the hand.

      ## Examples

          iex> deck = Cards.create_deck
          iex> {hand, deck} = Cards.deal(deck , 1)
          iex> hand
          ["Ace of Spades"]


    """
   def deal(deck, hand_size) do
      Enum.split(deck, hand_size) #Returns a tuple
   end

   def save(deck, filename) do   #Cards.save(deck, 'my_deck')
      binary = :erlang.term_to_binary(deck) #Encode the data to safely store in non erlang file system
      File.write(filename, binary)
   end

   #Read the data above by running File.read("my_deck")

   def load(filename) do
      case File.read(filename) do
        {:ok, binary} -> :erlang.binary_to_term binary #comparision and assignment
        {:error, _reason} -> "That file does not exist"
      end
   end

   def create_hand(hand_size) do #All modules in one
      Cards.create_deck
      |> Cards.shuffle
      |> Cards.deal(hand_size)

   end

 end

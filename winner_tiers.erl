-module(winner_tiers).
-include_lib("eunit/include/eunit.hrl").
-compile(export_all).

newcomer_test() -> 
  Arenas = {{nil, nil}, []},
  ?assertEqual(join(Arenas, contestant1), {{contestant1, nil}, []}).

challenger_test() ->
  Arenas = {{existing, nil}, []},
  ?assertEqual(join(Arenas, contestant2), {{existing, contestant2}, []}).

queue_test() ->
  Arenas = {{existing, challenger}, []},
  Arenas2 = join(Arenas, contestant3),
  ?assertEqual(Arenas2, {{existing, challenger}, [contestant3]}),
  Arenas3 = join(Arenas2, contestant4),
  ?assertEqual(Arenas3, {{existing, challenger}, [contestant3, contestant4]}).

join({{nil, nil}, Queue}, Newcomer) -> {{Newcomer, nil}, Queue};
join({{Existing, nil}, Queue}, Newcomer) -> {{Existing, Newcomer}, Queue};
join({{Contestant1, Contestant2}, Queue}, Newcomer) -> 
  {{Contestant1, Contestant2}, lists:append(Queue, [Newcomer])}.
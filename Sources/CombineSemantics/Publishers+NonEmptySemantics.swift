import Combine

extension Deferred: NonEmptySemantics where DeferredPublisher: NonEmptySemantics {}
// Empty is incompatible with NonEmptySemantics
extension Fail: NonEmptySemantics {}
extension Future: NonEmptySemantics {}
extension Just: NonEmptySemantics {}

extension Publishers.AllSatisfy: NonEmptySemantics {}
extension Publishers.AssertNoFailure: NonEmptySemantics where Upstream: NonEmptySemantics {}
extension Publishers.Autoconnect: NonEmptySemantics where Upstream: NonEmptySemantics {}
extension Publishers.Breakpoint: NonEmptySemantics where Upstream: NonEmptySemantics {}
extension Publishers.Buffer: NonEmptySemantics where Upstream: NonEmptySemantics {}
extension Publishers.Catch: NonEmptySemantics where Upstream: NonEmptySemantics {}
extension Publishers.Collect: NonEmptySemantics {}
extension Publishers.CollectByCount: NonEmptySemantics where Upstream: NonEmptySemantics {}
extension Publishers.CollectByTime: NonEmptySemantics where Upstream: NonEmptySemantics {}
extension Publishers.CombineLatest: NonEmptySemantics where  A: NonEmptySemantics, B: NonEmptySemantics {}
extension Publishers.CombineLatest3: NonEmptySemantics where  A: NonEmptySemantics, B: NonEmptySemantics, C: NonEmptySemantics {}
extension Publishers.CombineLatest4: NonEmptySemantics where  A: NonEmptySemantics, B: NonEmptySemantics, C: NonEmptySemantics, D: NonEmptySemantics {}
// Publishers.CompactMap is incompatible with NonEmptySemantics
extension Publishers.Comparison: NonEmptySemantics where Upstream: NonEmptySemantics {}
extension Publishers.Concatenate: NonEmptySemantics where Prefix: NonEmptySemantics {} // FIXME: or Suffix
extension Publishers.Contains: NonEmptySemantics {}
extension Publishers.ContainsWhere: NonEmptySemantics {}
extension Publishers.Count: NonEmptySemantics {}
// TODO: extension Publishers.Debounce: NonEmptySemantics where Upstream: NonEmptySemantics {}
extension Publishers.Decode: NonEmptySemantics where Upstream: NonEmptySemantics {}
extension Publishers.Delay: NonEmptySemantics where Upstream: NonEmptySemantics {}
// Publishers.Drop is incompatible with NonEmptySemantics
// Publishers.DropUntilOutput is incompatible with NonEmptySemantics
// Publishers.DropWhile is incompatible with NonEmptySemantics
extension Publishers.Encode: NonEmptySemantics where Upstream: NonEmptySemantics {}
// Publishers.Filter is incompatible with NonEmptySemantics
extension Publishers.First: NonEmptySemantics where Upstream: NonEmptySemantics {}
// Publishers.FirstWhere is incompatible with NonEmptySemantics
extension Publishers.FlatMap: NonEmptySemantics where NewPublisher: NonEmptySemantics, Upstream: NonEmptySemantics {}
extension Publishers.HandleEvents: NonEmptySemantics where Upstream: NonEmptySemantics {}
// Publishers.IgnoreOutput is incompatible with NonEmptySemantics
extension Publishers.Last: NonEmptySemantics where Upstream: NonEmptySemantics {}
// Publishers.LastWhere is incompatible with NonEmptySemantics
extension Publishers.MakeConnectable: NonEmptySemantics where Upstream: NonEmptySemantics {}
extension Publishers.Map: NonEmptySemantics where Upstream: NonEmptySemantics {}
extension Publishers.MapError: NonEmptySemantics where Upstream: NonEmptySemantics {}
extension Publishers.MapKeyPath: NonEmptySemantics where Upstream: NonEmptySemantics {}
extension Publishers.MapKeyPath2: NonEmptySemantics where Upstream: NonEmptySemantics {}
extension Publishers.MapKeyPath3: NonEmptySemantics where Upstream: NonEmptySemantics {}
extension Publishers.MeasureInterval: NonEmptySemantics where Upstream: NonEmptySemantics {}
extension Publishers.Merge: NonEmptySemantics where A: NonEmptySemantics {} // FIXME: or B
extension Publishers.Merge3: NonEmptySemantics where A: NonEmptySemantics {} // FIXME: or B or C
extension Publishers.Merge4: NonEmptySemantics where A: NonEmptySemantics {} // FIXME: or B or C or D
extension Publishers.Merge5: NonEmptySemantics where A: NonEmptySemantics {} // FIXME: or B or C or D or E
extension Publishers.Merge6: NonEmptySemantics where A: NonEmptySemantics {} // FIXME: or B or C or D or E or F
extension Publishers.Merge7: NonEmptySemantics where A: NonEmptySemantics {} // FIXME: or B or C or D or E or F or G
extension Publishers.Merge8: NonEmptySemantics where A: NonEmptySemantics {} // FIXME: or B or C or D or E or F or G or H
extension Publishers.MergeMany: NonEmptySemantics where Upstream: NonEmptySemantics {}
extension Publishers.Multicast: NonEmptySemantics where Upstream: NonEmptySemantics {}
// Publishers.Output is incompatible with NonEmptySemantic
// Publishers.PrefixUntilOutput is incompatible with NonEmptySemantic
// Publishers.PrefixWhile is incompatible with NonEmptySemantic
extension Publishers.Print: NonEmptySemantics where Upstream: NonEmptySemantics {}
extension Publishers.ReceiveOn: NonEmptySemantics where Upstream: NonEmptySemantics {}
extension Publishers.Reduce: NonEmptySemantics {}
extension Publishers.RemoveDuplicates: NonEmptySemantics where Upstream: NonEmptySemantics {}
extension Publishers.ReplaceEmpty: NonEmptySemantics {}
extension Publishers.ReplaceError: NonEmptySemantics where Upstream: NonEmptySemantics {}
extension Publishers.Retry: NonEmptySemantics where Upstream: NonEmptySemantics {}
extension Publishers.Scan: NonEmptySemantics where Upstream: NonEmptySemantics {}
// Publishers.Sequence is incompatible with NonEmptySemantic
extension Publishers.SetFailureType: NonEmptySemantics where Upstream: NonEmptySemantics {}
extension Publishers.Share: NonEmptySemantics where Upstream: NonEmptySemantics {}
extension Publishers.SubscribeOn: NonEmptySemantics where Upstream: NonEmptySemantics {}
extension Publishers.SwitchToLatest: NonEmptySemantics where Upstream: NonEmptySemantics, Upstream.Output: NonEmptySemantics {}
extension Publishers.Throttle: NonEmptySemantics where Upstream: NonEmptySemantics {}
extension Publishers.TryAllSatisfy: NonEmptySemantics {}
extension Publishers.TryCatch: NonEmptySemantics where Upstream: NonEmptySemantics {}
// Publishers.TryCompactMap is incompatible with NonEmptySemantic
extension Publishers.TryComparison: NonEmptySemantics where Upstream: NonEmptySemantics {}
extension Publishers.TryContainsWhere: NonEmptySemantics {}
// Publishers.TryDropWhile is incompatible with NonEmptySemantic
// Publishers.TryFilter is incompatible with NonEmptySemantic
// Publishers.TryFirstWhere is incompatible with NonEmptySemantic
// Publishers.TryLastWhere is incompatible with NonEmptySemantic
extension Publishers.TryMap: NonEmptySemantics where Upstream: NonEmptySemantics {}
// Publishers.TryPrefixWhile is incompatible with NonEmptySemantic
extension Publishers.TryReduce: NonEmptySemantics {}
extension Publishers.TryRemoveDuplicates: NonEmptySemantics where Upstream: NonEmptySemantics {}
extension Publishers.TryScan: NonEmptySemantics where Upstream: NonEmptySemantics {}
extension Publishers.Zip: NonEmptySemantics where A: NonEmptySemantics, B: NonEmptySemantics {}
extension Publishers.Zip3: NonEmptySemantics where A: NonEmptySemantics, B: NonEmptySemantics, C: NonEmptySemantics {}
extension Publishers.Zip4: NonEmptySemantics where A: NonEmptySemantics, B: NonEmptySemantics, C: NonEmptySemantics, D: NonEmptySemantics {}

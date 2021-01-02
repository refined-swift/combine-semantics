import Combine

extension Deferred: SingleValueSemantics where DeferredPublisher: SingleValueSemantics {}
// Empty is incompatible with SingleValueSemantics
extension Fail: SingleValueSemantics {}
extension Future: SingleValueSemantics {}
extension Just: SingleValueSemantics {}

extension Publishers.AllSatisfy: SingleValueSemantics {}
extension Publishers.AssertNoFailure: SingleValueSemantics where Upstream: SingleValueSemantics {}
extension Publishers.Autoconnect: SingleValueSemantics where Upstream: SingleValueSemantics {}
extension Publishers.Breakpoint: SingleValueSemantics where Upstream: SingleValueSemantics {}
extension Publishers.Buffer: SingleValueSemantics where Upstream: SingleValueSemantics {}
extension Publishers.Catch: SingleValueSemantics where Upstream: SingleValueSemantics {}
extension Publishers.Collect: SingleValueSemantics {}
extension Publishers.CollectByCount: SingleValueSemantics where Upstream: SingleValueSemantics {}
extension Publishers.CollectByTime: SingleValueSemantics where Upstream: SingleValueSemantics {}
extension Publishers.CombineLatest: SingleValueSemantics where  A: SingleValueSemantics, B: SingleValueSemantics {}
extension Publishers.CombineLatest3: SingleValueSemantics where  A: SingleValueSemantics, B: SingleValueSemantics, C: SingleValueSemantics {}
extension Publishers.CombineLatest4: SingleValueSemantics where  A: SingleValueSemantics, B: SingleValueSemantics, C: SingleValueSemantics, D: SingleValueSemantics {}
// Publishers.CompactMap is incompatible with SingleValueSemantics
extension Publishers.Comparison: SingleValueSemantics where Upstream: NonEmptySemantics {}
// Publishers.Concatenate is incompatible with SingleValueSemantics
extension Publishers.Contains: SingleValueSemantics {}
extension Publishers.ContainsWhere: SingleValueSemantics {}
extension Publishers.Count: SingleValueSemantics {}
// TODO: extension Publishers.Debounce: SingleValueSemantics where Upstream: SingleValueSemantics {}
extension Publishers.Decode: SingleValueSemantics where Upstream: SingleValueSemantics {}
extension Publishers.Delay: SingleValueSemantics where Upstream: SingleValueSemantics {}
// Publishers.Drop is incompatible with SingleValueSemantics
// Publishers.DropUntilOutput is incompatible with SingleValueSemantics
// Publishers.DropWhile is incompatible with SingleValueSemantics
extension Publishers.Encode: SingleValueSemantics where Upstream: SingleValueSemantics {}
// Publishers.Filter is incompatible with SingleValueSemantics
extension Publishers.First: SingleValueSemantics where Upstream: NonEmptySemantics {}
// Publishers.FirstWhere is incompatible with SingleValueSemantics
extension Publishers.FlatMap: SingleValueSemantics where NewPublisher: SingleValueSemantics, Upstream: SingleValueSemantics {}
extension Publishers.HandleEvents: SingleValueSemantics where Upstream: SingleValueSemantics {}
// Publishers.IgnoreOutput is incompatible with SingleValueSemantics
extension Publishers.Last: SingleValueSemantics where Upstream: NonEmptySemantics {}
// Publishers.LastWhere is incompatible with SingleValueSemantics
extension Publishers.MakeConnectable: SingleValueSemantics where Upstream: SingleValueSemantics {}
extension Publishers.Map: SingleValueSemantics where Upstream: SingleValueSemantics {}
extension Publishers.MapError: SingleValueSemantics where Upstream: SingleValueSemantics {}
extension Publishers.MapKeyPath: SingleValueSemantics where Upstream: SingleValueSemantics {}
extension Publishers.MapKeyPath2: SingleValueSemantics where Upstream: SingleValueSemantics {}
extension Publishers.MapKeyPath3: SingleValueSemantics where Upstream: SingleValueSemantics {}
extension Publishers.MeasureInterval: SingleValueSemantics where Upstream: SingleValueSemantics {}
// Publishers.Merge is incompatible with SingleValueSemantics
// Publishers.Merge3 is incompatible with SingleValueSemantics
// Publishers.Merge4 is incompatible with SingleValueSemantics
// Publishers.Merge5 is incompatible with SingleValueSemantics
// Publishers.Merge6 is incompatible with SingleValueSemantics
// Publishers.Merge7 is incompatible with SingleValueSemantics
// Publishers.Merge8 is incompatible with SingleValueSemantics
// Publishers.MergeMany is incompatible with SingleValueSemantics
extension Publishers.Multicast: SingleValueSemantics where Upstream: SingleValueSemantics {}
// Publishers.Output is incompatible with SingleValueSemantics
// Publishers.PrefixUntilOutput is incompatible with SingleValueSemantics
// Publishers.PrefixWhile is incompatible with SingleValueSemantics
extension Publishers.Print: SingleValueSemantics where Upstream: SingleValueSemantics {}
extension Publishers.ReceiveOn: SingleValueSemantics where Upstream: SingleValueSemantics {}
extension Publishers.Reduce: SingleValueSemantics {}
extension Publishers.RemoveDuplicates: SingleValueSemantics where Upstream: SingleValueSemantics {}
extension Publishers.ReplaceEmpty: SingleValueSemantics where Upstream: SingleValueSemantics {}
extension Publishers.ReplaceError: SingleValueSemantics where Upstream: SingleValueSemantics {}
extension Publishers.Retry: SingleValueSemantics where Upstream: SingleValueSemantics {}
extension Publishers.Scan: SingleValueSemantics where Upstream: SingleValueSemantics {}
// Publishers.Sequence is incompatible with SingleValueSemantics
extension Publishers.SetFailureType: SingleValueSemantics where Upstream: SingleValueSemantics {}
extension Publishers.Share: SingleValueSemantics where Upstream: SingleValueSemantics {}
extension Publishers.SubscribeOn: SingleValueSemantics where Upstream: SingleValueSemantics {}
extension Publishers.SwitchToLatest: SingleValueSemantics where Upstream: SingleValueSemantics, Upstream.Output: SingleValueSemantics {}
extension Publishers.Throttle: SingleValueSemantics where Upstream: SingleValueSemantics {}
extension Publishers.TryAllSatisfy: SingleValueSemantics {}
extension Publishers.TryCatch: SingleValueSemantics where Upstream: SingleValueSemantics {}
// Publishers.TryCompactMap is incompatible with SingleValueSemantics
extension Publishers.TryComparison: SingleValueSemantics where Upstream: NonEmptySemantics {}
extension Publishers.TryContainsWhere: SingleValueSemantics {}
// Publishers.TryDropWhile is incompatible with SingleValueSemantics
// Publishers.TryFilter is incompatible with SingleValueSemantics
// Publishers.TryFirstWhere is incompatible with SingleValueSemantics
// Publishers.TryLastWhere is incompatible with SingleValueSemantics
extension Publishers.TryMap: SingleValueSemantics where Upstream: SingleValueSemantics {}
// Publishers.TryPrefixWhile is incompatible with SingleValueSemantics
extension Publishers.TryReduce: SingleValueSemantics {}
extension Publishers.TryRemoveDuplicates: SingleValueSemantics where Upstream: SingleValueSemantics {}
extension Publishers.TryScan: SingleValueSemantics where Upstream: SingleValueSemantics {}
extension Publishers.Zip: SingleValueSemantics where A: SingleValueSemantics, B: SingleValueSemantics {}
extension Publishers.Zip3: SingleValueSemantics where A: SingleValueSemantics, B: SingleValueSemantics, C: SingleValueSemantics {}
extension Publishers.Zip4: SingleValueSemantics where A: SingleValueSemantics, B: SingleValueSemantics, C: SingleValueSemantics, D: SingleValueSemantics {}

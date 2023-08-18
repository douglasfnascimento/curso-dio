let steve = "Steve"
var jobs: String? = "Jobs"

print("\(steve) \(jobs ?? "Wozniak")")

if let jobs {
    print("\(steve) \(jobs)")
} else {
    print("\(steve) Wozniak")
}

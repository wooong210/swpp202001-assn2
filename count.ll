define i32 @count_even(i32* %arr, i32 %N) {
  ; Count the number of evens from
  ; %arr[0 … %N - 1]
  ; precond: 0 <= N <= 20
	
	entry:
		br label %for.header
	
	for.header:
		%i = phi i32 [0, %entry], [%i.next, %latch]
		%count = phi i32 [0, %entry], [%count.next, %latch]
		%cond = icmp slt i32 %i, %N
		br i1 %cond, label %body, label %exit
	
	body:
		%addr = getelementptr inbounds i32, i32* %arr, i32 %i
		%data = load i32, i32* %addr
		%odd = urem i32 %data, 2
		%isodd = icmp eq i32 %odd, 0
		br i1 %isodd, label %btrue, label %latch

	btrue:
		%count1 = add i32 %count, 1
		br label %latch
	
	latch:
		%count.next = phi i32 [%count, %body], [%count1, %btrue]
		%i.next = add nsw i32 %i, 1
		br label %for.header
	
	exit:
  	ret i32 %count
}

Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154600-29165>; Sat, 5 Sep 1998 09:34:07 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:8803 "EHLO penguin.e-mind.com" ident: "TIMEDOUT") by vger.rutgers.edu with ESMTP id <154601-29165>; Sat, 5 Sep 1998 09:32:06 -0400
Date: Sat, 5 Sep 1998 14:00:34 +0200 (CEST)
From: Andrea Arcangeli <arcangeli@mbox.queen.it>
To: Marty Leisner <leisner@twcny.rr.com>
cc: "Eric S. Raymond" <esr@thyrsus.com>, linux-net@vger.rutgers.edu, linux-kernel@vger.rutgers.edu
Subject: Re: Linux tcp/ip code has trouble with async network I/O  notification,u
In-Reply-To: <199809040420.AAA02211@rochester.rr.com>
Message-ID: <Pine.LNX.3.96.980905135552.405A-100000@dragon.bogus>
X-PgP-Public-Key-URL: http://e-mind.com/~andrea/aa.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Fri, 4 Sep 1998, Marty Leisner wrote:

>I agree with Eric's basic problems with threads...
>
>A good, single threaded solution is far superior, easier, more
>maintainable, etc. etc. then threads...
>
>
>For more on why threads are a bad idea (usually) see:
>http://www.scriptics.com/people/john.ousterhout/

That document about threads is very very generic (>10 page of repetitions)
and not interesting. I don' t like such kind of docs (it seems to me to
study for University also in the spare time). 

The only right repeated point is that threads are well used when there is
high CPU usage for every thread.

Andrea[s] Arcangeli


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/faq.html

Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <155172-14821>; Fri, 30 Apr 1999 20:36:39 -0400
Received: by vger.rutgers.edu id <154658-14823>; Fri, 30 Apr 1999 20:36:28 -0400
Received: from [209.198.197.200] ([209.198.197.200]:1522 "EHLO fisicc-ufm.edu" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <155397-14821>; Fri, 30 Apr 1999 20:36:23 -0400
Message-ID: <372A5336.42B8EAF4@fisicc-ufm.edu>
Date: Fri, 30 Apr 1999 19:04:54 -0600
From: Otto Solares <solca@fisicc-ufm.edu>
Organization: FISICC-UFM
X-Mailer: Mozilla 4.5 [en] (X11; I; Linux 2.2.6 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.rutgers.edu
Subject: Re: Performance Comparision
References: <Pine.LNX.4.05.9904300049570.502-100000@laser.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Andrea Arcangeli wrote:

> On Thu, 29 Apr 1999, Otto Solares wrote:
>
> >I realize a benchmark within different operating systems and
> >different architectures and processors with a tool know as
>
> Please could you try also 2.2.7_andrea2.bz2?? I would be very very very
> interested at least about the swap or VM-intensive-operations information.
> Obviously it would be better to run the bench on the same 300Mhz machine
> where you did all other bench.
>
>         ftp://e-mind.com/pub/andrea/kernel/2.2.7_andrea2.bz2
>
> >I am the administrator (network/system) in a University
> >in Guatemala and i have installed like 150 boxes with linux so
> >if you want more tests i have a full featured lab! ;)
>
> Cool!! so please try out my new VM code! :))
>
> Thanks.
>
> Andrea Arcangeli
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.rutgers.edu
> Please read the FAQ at http://www.tux.org/lkml/

I have finally tested your VM code using 2.2.7 and 2.2.7andrea patch and
i have to say that it add performance but no too much in the HINT
benchmark, the graph is tha same and in tha last part (swap) it raise a
little but the graph in the last part is minimized so is a real gain in
performance,
i calculate like 10%, congratulations!

Hope will be integrated in the next release :)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/

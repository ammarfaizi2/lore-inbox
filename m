Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154706AbQDWDet>; Sat, 22 Apr 2000 23:34:49 -0400
Received: by vger.rutgers.edu id <S154411AbQDWDej>; Sat, 22 Apr 2000 23:34:39 -0400
Received: from [200.250.58.146] ([200.250.58.146]:62182 "EHLO duckman.conectiva") by vger.rutgers.edu with ESMTP id <S154230AbQDWDeZ>; Sat, 22 Apr 2000 23:34:25 -0400
Date: Sun, 23 Apr 2000 00:38:49 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
Reply-To: riel@nl.linux.org
To: moussakx@jmu.edu
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: Scheduler
In-Reply-To: <Pine.PMDF.3.96.1000422230952.692947A-100000@RAVEN.JMU.EDU>
Message-ID: <Pine.LNX.4.21.0004230037280.24495-100000@duckman.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Sat, 22 Apr 2000 moussakx@jmu.edu wrote:

> I am currently in the process of deciphering the function
> hierarchy of the Linux scheduler ("sched.c").  I was wondering
> if you would happen to know where I could get my hands on a flow
> chart of the functions in this file ("sched.c")?

http://www.surriel.com/lectures/

The kernel tour lecture explains the gist of the scheduler
in 4 slides. Once you understand those you'll be able to
look at the real code without getting lost...

regards,

Rik
--
The Internet is not a network of computers. It is a network
of people. That is its real strength.

Wanna talk about the kernel?  irc.openprojects.net / #kernelnewbies
http://www.conectiva.com/		http://www.surriel.com/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/

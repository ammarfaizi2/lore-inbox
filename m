Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291531AbSBYQGL>; Mon, 25 Feb 2002 11:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291148AbSBYQFv>; Mon, 25 Feb 2002 11:05:51 -0500
Received: from adsl-217-220.38-151.net24.it ([151.38.220.217]:3510 "EHLO
	valeria.casa") by vger.kernel.org with ESMTP id <S293288AbSBYQFm>;
	Mon, 25 Feb 2002 11:05:42 -0500
Date: Mon, 25 Feb 2002 17:05:41 +0100 (CET)
From: marco <marco@tux.dynu.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: suparna@in.ibm.com, linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Kernel support of socket async I/O
Message-ID: <Pine.LNX.4.21.0202251521440.27334-100000@valeria.casa>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Benjamin and all of the guys on the lists,
I'm pretty much interested in socket async I/O for a project at work. I
read the document at 

http://lse.sourceforge.net/io/aionotes.txt

and I saw that patches are available at

http://kanga.kvack.org/~blah/aio/

I also searched linux-kernel archives for some status information, but
couldn't gain much info (other than a couple of discussion threads back in
late 1999).
What we need is a standard aio/thread-pool-in-sigwaitinfo architecture and
we wouldn't like to use select/poll.

I would also like to contribute on this project if it could somehow help 
(if my boss lets me, of course ...)

I promise to narrow the distribution as long as I know who to talk to!
Thanks,
Marco.



---------------------------------------------------

      ~
     . .
     /V\     Computers are like air conditioners.
    // \\   They stop working when you open Windows.
   /(   )\
    ^`~'^



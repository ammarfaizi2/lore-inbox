Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318355AbSHEJs0>; Mon, 5 Aug 2002 05:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318356AbSHEJs0>; Mon, 5 Aug 2002 05:48:26 -0400
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:37615 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S318355AbSHEJsZ>; Mon, 5 Aug 2002 05:48:25 -0400
Date: Mon, 5 Aug 2002 10:51:57 +0100
From: Anthony Campbell <ac@acampbell.org.uk>
To: linux-kernel@vger.kernel.org
Cc: mec@shout.net
Subject: xconfig and menuconfig no longer work
Message-ID: <20020805095157.GA8609@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've suddenly encountered problems with "make menuconfig" and "make
xconfig". These always worked perfectly previously on 2.4.18. I now get it on
2.4.18 and 2.4.19.

Now, "make menuconfig" gives a message saying:

	Menuconfig has encountered a possible error in one of the
	kernel's configuration files and is unable to continue. Here is
	the error report: [there is no report]

And "make xconfig" fails with the message:

	.tkparse: Permission denied

This happens even as root.

To make matters even more puzzling, these problems occur only on my
laptop; both work on my desktop. Both machines are running Debian
(testing).

Any suggestions gratefully received; please reply by email as I am not
on the list at present.

Anthony
	
	

-- 
ac@acampbell.org.uk    ||  http://www.acampbell.org.uk
using Linux GNU/Debian ||  for book reviews, electronic 
Windows-free zone      ||  books and skeptical articles

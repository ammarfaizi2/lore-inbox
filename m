Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262693AbTDMBll (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 21:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262701AbTDMBll (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 21:41:41 -0400
Received: from ms-smtp-02.tampabay.rr.com ([65.32.1.39]:24493 "EHLO
	ms-smtp-02.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S262693AbTDMBlk (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 21:41:40 -0400
Message-ID: <001101c30160$5a9ca790$6801a8c0@epimetheus>
From: "Timothy Miller" <tmiller10@cfl.rr.com>
To: "Jan Knutar" <jk-lkml@sci.fi>, <linux-kernel@vger.kernel.org>
References: <000d01c30143$ccf54ad0$6801a8c0@epimetheus> <03041303065500.26409@polaris>
Subject: Re: Page compression in lieu of swap?
Date: Sat, 12 Apr 2003 21:59:43 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Jan Knutar" <jk-lkml@sci.fi>

> On Sunday 13 April 2003 01:35, Timothy Miller wrote:
> > I did some searching of the kernel archives and the only things
> > related to the forthcoming idea had to do with compressing pages when
> > writing to swap and doing compressed disks.  Here's a different
> > idea...
>
> http://linuxcompressed.sourceforge.net/
>
> This the same thing?
>


I believe it is!

Anyone on the list checked it out?  Is it good?  Any benchmarks performed?
Do we want it?

If it doesn't introduce instability, then it could be a very good addition.
Perhaps at the beginning of the 2.7 phase?  If were to be in a develoment
kernel for its entire life, it would certainly get all the bugs worked out.

Does Linus have an opinion on it?

One of the things that makes me like Linux the best is that the contributors
really seem to push the envelope.  Of course, I don't know really how well
other OS's do in that regard, but I wouldn't be surprised if we were leaving
other OS's like Windows, Solaris, and MacOS in the dust with some of the
cool things being worked on like the O(1) scheduler, the anticipatory I/O
scheduler, etc.  Maybe others have such things.  <shrug>

Sorry about the rambling.




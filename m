Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263299AbTLJCnA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 21:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbTLJCnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 21:43:00 -0500
Received: from web20022.mail.yahoo.com ([216.136.225.24]:33899 "HELO
	web20022.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263299AbTLJCm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 21:42:59 -0500
Message-ID: <20031210024258.26284.qmail@web20022.mail.yahoo.com>
Date: Tue, 9 Dec 2003 18:42:58 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: [NFS client] NFS locks not released on abnormal process termination
To: Philippe Troin <phil@fifi.org>, trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
In-Reply-To: <8765gpvnfv.fsf@ceramic.fifi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've ran test overnight on four boxen, and no locks were lost.
> I guess you can send this patch to Marcello now.
>
Excellent work!

> > There are still 2 other issues with the generic POSIX locking code.
> > Both issues have to do with CLONE_VM and have been raised on
> > linux-kernel & linux-fsdevel. Unfortunately they met with no response,
> > so I'm unable to pursue...
> 
> Can we help? Pointers?
Let me know if/how I can help.

Again, great work.

thanks,
-Kenny

__________________________________
Do you Yahoo!?
Free Pop-Up Blocker - Get it now
http://companion.yahoo.com/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318115AbSGWPO5>; Tue, 23 Jul 2002 11:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318116AbSGWPO4>; Tue, 23 Jul 2002 11:14:56 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:56825 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318115AbSGWPO4>; Tue, 23 Jul 2002 11:14:56 -0400
Subject: Re: is flock broken in 2.4 or 2.5 kernels or what does this mean?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Covici <covici@ccs.covici.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m37kjmik0g.fsf@ccs.covici.com>
References: <m37kjmik0g.fsf@ccs.covici.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 23 Jul 2002 17:31:12 +0100
Message-Id: <1027441872.31787.139.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-23 at 15:41, John Covici wrote:
> In the latest release notes of sendmail I have read the following:
> 
> 		NOTE: Linux appears to have broken flock() again.  Unless
> 			the bug is fixed before sendmail 8.13 is shipped,
> 			8.13 will change the default locking method to
> 			fcntl() for Linux kernel 2.4 and later.  You may
> 			want to do this in 8.12 by compiling with
> 			-DHASFLOCK=0.  Be sure to update other sendmail
> 			related programs to match locking techniques.
> 
> Can anyone tell me what this is all about -- is there any basis in
> reality for what they are saying?

First I've heard of it, so it would be useful if someone has access to
the sendmail problem report/test in question that shows it and I'll go
find out.


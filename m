Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261242AbSKBPEC>; Sat, 2 Nov 2002 10:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261246AbSKBPEC>; Sat, 2 Nov 2002 10:04:02 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:37514 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261242AbSKBPEC>; Sat, 2 Nov 2002 10:04:02 -0500
Subject: Re: What's left over.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Steven King <sxking@qwest.net>, Linus Torvalds <torvalds@transmeta.com>,
       Joel Becker <Joel.Becker@oracle.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.3.96.1021102000343.29692C-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1021102000343.29692C-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Nov 2002 15:29:27 +0000
Message-Id: <1036250967.16803.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-02 at 05:17, Bill Davidsen wrote:
>   I was hoping Alan would push Redhat to put this in their Linux so we
> could resolve some of the ongoing problems which don't write an oops to a
> log, but I guess none of the developers has to actually support production
> servers and find out why they crash.

I think several Red Hat people would disagree very strongly. Red Hat
shipped with the kernel symbol decoding oops reporter for a good reason,
and also acquired netdump for a good reason. 

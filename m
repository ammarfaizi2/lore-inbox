Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261461AbSJCQY4>; Thu, 3 Oct 2002 12:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261475AbSJCQY4>; Thu, 3 Oct 2002 12:24:56 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:8434 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261461AbSJCQYz>; Thu, 3 Oct 2002 12:24:55 -0400
Subject: Re: [OT] 2.6 not 3.0 - (WAS Re: [PATCH-RFC] 4 of 4 - New problem
	logging macros, SCSI RAIDdevice)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: jbradford@dial.pipex.com, jgarzik@pobox.com, kessler@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       saw@saw.sw.com.sg, rusty@rustcorp.com.au, richardj_moore@uk.ibm.com
In-Reply-To: <Pine.LNX.4.44.0210030852330.2066-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0210030852330.2066-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Oct 2002 17:37:58 +0100
Message-Id: <1033663078.28850.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-03 at 16:57, Linus Torvalds wrote:
> 
> On Thu, 3 Oct 2002 jbradford@dial.pipex.com wrote:
> > 
> > I think we should stick to incrementing the major number when binary
> > compatibility is broken.
> 
> "Stick to"? We've never had that as any criteria for major numbers in the
> kernel. Binary compatibility has _never_ been broken as a release policy,
> only as a "that code is old, and we've given people 5 years to migrate to
> the new system calls, the old ones are TOAST".

We've generally done better than that. Libc 2.2.2 stil works


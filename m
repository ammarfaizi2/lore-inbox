Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbVLYBbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbVLYBbU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 20:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbVLYBbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 20:31:20 -0500
Received: from CPE-24-31-244-49.kc.res.rr.com ([24.31.244.49]:36316 "EHLO
	tsurukikun.utopios.org") by vger.kernel.org with ESMTP
	id S1750780AbVLYBbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 20:31:19 -0500
From: Luke-Jr <luke@dashjr.org>
To: Lee Revell <rlrevell@joe-job.com>, Alon Bar-Lev <alon.barlev@gmail.com>,
       David Wagner <daw@cs.berkeley.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Question] LinuxThreads, setuid - Is there user mode hook?
Date: Sun, 25 Dec 2005 01:31:15 +0000
User-Agent: KMail/1.9
References: <200512222312.jBMNCj96018554@taverner.CS.Berkeley.EDU> <1135370197.22177.40.camel@mindpipe> <20051223203347.GA32589@nevyn.them.org>
In-Reply-To: <20051223203347.GA32589@nevyn.them.org>
Public-GPG-Key: 0xD53E9583
Public-GPG-Key-URI: http://dashjr.org/~luke-jr/myself/Luke-Jr.pgp
IM-Address: luke-jr@jabber.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512250131.19218.luke@dashjr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 December 2005 20:33, Daniel Jacobowitz wrote:
> Applications have to run on existing platforms and work with existing
> software, as I'm sure you know.  If someone anywhere in the food chain
> isn't ready for NPTL, a project can easily be stuck with LT for another
> few years.

Not sure about NPTL support in non-Linux-based operating systems (Solaris, 
BSD, etc), but I'd be surprised if they supported LinuxThreads. Thus, 
shouldn't NPTL really result in a *more* portable application?

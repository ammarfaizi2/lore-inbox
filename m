Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265148AbUE2Prd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265148AbUE2Prd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 11:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbUE2Prc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 11:47:32 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:58240 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S265148AbUE2Pr2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 11:47:28 -0400
Date: Sat, 29 May 2004 08:47:14 -0700
From: Larry McVoy <lm@bitmover.com>
To: Hugo Mills <hugo-lkml@carfax.org.uk>, Vojtech Pavlik <vojtech@suse.cz>,
       bitkeeper-announce@work.bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: bk-3.2.0 released
Message-ID: <20040529154714.GC20605@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Hugo Mills <hugo-lkml@carfax.org.uk>,
	Vojtech Pavlik <vojtech@suse.cz>,
	bitkeeper-announce@work.bitmover.com, linux-kernel@vger.kernel.org
References: <20040518233238.GC28206@work.bitmover.com> <20040529095419.GB1269@ucw.cz> <20040529130436.GA20605@work.bitmover.com> <20040529131510.GB13999@selene>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040529131510.GB13999@selene>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    It'll allow BK to be run on machines which have a pure 64-bit
> userspace (for example, Debian's current amd64 port), without having
> to resort to a 32-bit chroot to run the 32-bit BK binary.

OK, I found a reasonable looking box at 

    http://www.bzboyz.com/store/product4170.html

ASUS K8V basic, AMD 64 2800+, $346.  Gotta love hardware prices.

Next question is what distro you'd prefer to be the build OS.
We typically use Red Hat, in this case that would be Fedora Core 1.
Since that was one of the first (?) distros for x86-64 there shouldn't
be any libc issues, right?  What we want is to use the _oldest_ possible
distro/libc that works going forward.  So is Fedora 1 OK with you?  Any
nay sayers?
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com

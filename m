Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268423AbUHYD2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268423AbUHYD2g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 23:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268435AbUHYD2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 23:28:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:41661 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268423AbUHYD2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 23:28:34 -0400
Date: Tue, 24 Aug 2004 20:17:44 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Joshua Kwan <joshk@triplehelix.org>
Cc: davem@redhat.com, lcaron@apartia.fr, linux-kernel@vger.kernel.org
Subject: Re: TG3(Tigoon) & Kernel 2.4.27
Message-Id: <20040824201744.559319ef.rddunlap@osdl.org>
In-Reply-To: <412BED65.5060709@triplehelix.org>
References: <412B5B35.7020701@apartia.fr>
	<20040824092533.65cb32da.rddunlap@osdl.org>
	<20040824113407.287f0408.davem@redhat.com>
	<412BED65.5060709@triplehelix.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2004 18:37:41 -0700 Joshua Kwan wrote:

| David S. Miller wrote:
| > Oh on the contrary, I've never seen a call to request_firmware()
| > in any copy of the tg3 driver and that's strange being that I'm
| > the maintainer. :-)
| > 
| > People, if you're going to use patched up kernels, report your
| > problems to the people you got the kernel from.  Thanks.
| 
| As a matter of fact this is most certainly kernel-source-2.4.27 from 
| Debian. This problem was recently fixed (as discussed in the mini-thread 
| about how CML1 blows chunks.)
| 
| For what it's worth to Google, kernel-tree-2.4.27-4 has just hit 
| unstable (will reach mirrors by tomorrow) and should have fixed this 
| problem.
| 
| Sorry for the noise caused to LKML.

Please don't drop people from to: / cc:

--
~Randy

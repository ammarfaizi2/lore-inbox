Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbUA3LKZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 06:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbUA3LKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 06:10:25 -0500
Received: from 213-145-178-72.dd.nextgentel.com ([213.145.178.72]:2486 "EHLO
	terminal124.gozu.lan") by vger.kernel.org with ESMTP
	id S261575AbUA3LKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 06:10:21 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.2-rc2-mm2
References: <1jDrO-4xh-13@gated-at.bofh.it>
From: s864@ii.uib.no (Ronny V. Vindenes)
Date: 30 Jan 2004 12:10:09 +0100
In-Reply-To: <1jDrO-4xh-13@gated-at.bofh.it>
Message-ID: <m3d691n14e.fsf@terminal124.gozu.lan>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc2/2.6.2-rc2-mm2/
> 
> 
> - I added a few late-arriving patches.  Usually this breaks things.
> 

I got a reject in include/linux/sched.h, it still compiles but doesn't boot,
the harddisks (2 sata + a pata) makes some wierd noises but no signs
of booting. -mm1 works fine (with the futex debug patch reverted).

-- 
Ronny V. Vindenes <s864@ii.uib.no>

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbUBZInR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 03:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbUBZInR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 03:43:17 -0500
Received: from pileup.ihatent.com ([217.13.24.22]:4106 "EHLO
	pileup.ihatent.com") by vger.kernel.org with ESMTP id S262739AbUBZInP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 03:43:15 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm4
References: <20040225185536.57b56716.akpm@osdl.org>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 26 Feb 2004 09:22:37 +0100
In-Reply-To: <20040225185536.57b56716.akpm@osdl.org>
Message-ID: <87eksidzci.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3-mm4/
> 
> - Big knfsd update.  Mainly for nfsv4
> 
> - DVB udpate
> 
> - Various fixes
> 

And a few symbols that are not exported?

WARNING: /lib/modules/2.6.3-mm4/kernel/fs/quota_v2.ko needs unknown symbol mark_info_dirty
WARNING: /lib/modules/2.6.3-mm4/kernel/fs/nfsd/nfsd.ko needs unknown symbol locks_remove_posix
WARNING: /lib/modules/2.6.3-mm4/kernel/net/ipv6/ipv6.ko needs unknown symbol sysctl_optmem_max

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbVKZALL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbVKZALL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 19:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbVKZALK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 19:11:10 -0500
Received: from gold.veritas.com ([143.127.12.110]:38474 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750765AbVKZALK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 19:11:10 -0500
Date: Sat, 26 Nov 2005 00:11:10 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: root <root@txiringo.dyndns.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: your mail
In-Reply-To: <20051125220620.968F72404DC7@txiringo>
Message-ID: <Pine.LNX.4.61.0511260009080.13981@goblin.wat.veritas.com>
References: <20051125220620.968F72404DC7@txiringo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 26 Nov 2005 00:11:05.0600 (UTC) FILETIME=[E4C4C000:01C5F21D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2005, root wrote:

> Nov 25 21:59:24 txiringo kernel: [17182458.504000] program ddcprobe
> is using MAP_PRIVATE, PROT_WRITE mmap of VM_RESERVED memory, which
> is deprecated. Please report this to linux-kernel@vger.kernel.org

Thanks for the report: now fixed, please upgrade to 2.6.15-rc2-git3 or later.

Hugh

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267133AbTBRK3I>; Tue, 18 Feb 2003 05:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267200AbTBRK3I>; Tue, 18 Feb 2003 05:29:08 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:54282 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267133AbTBRK3G>; Tue, 18 Feb 2003 05:29:06 -0500
Date: Tue, 18 Feb 2003 10:39:06 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCHSET] PC-9800 subarch. support for 2.5.61 (3/26) mach-pc9800
Message-ID: <20030218103906.B11969@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Osamu Tomita <tomita@cinet.co.jp>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20030217134333.GA4734@yuzuki.cinet.co.jp> <20030217135137.GC4799@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030217135137.GC4799@yuzuki.cinet.co.jp>; from tomita@cinet.co.jp on Mon, Feb 17, 2003 at 10:51:37PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#ifdef CONFIG_NUMA
> +#include <linux/mmzone.h>
> +#include <asm/node.h>
> +#include <asm/memblk.h>

Are there NUMA PC98 machines?


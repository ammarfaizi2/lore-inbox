Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265490AbUHWPtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265490AbUHWPtp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 11:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265108AbUHWPrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 11:47:35 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:36994 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265684AbUHWPpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 11:45:18 -0400
Date: Mon, 23 Aug 2004 17:43:33 +0200
From: Jens Axboe <axboe@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com,
       ppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       LKML <linux-kernel@vger.kernel.org>, olh@suse.de
Subject: Re: [PATCH] PPC64 iSeries virtual DVD-RAM
Message-ID: <20040823154332.GA2301@suse.de>
References: <20040608224646.529860f4.sfr@canb.auug.org.au> <40C5E0CD.8060107@pobox.com> <20040609115035.2167efee.sfr@canb.auug.org.au> <20040609061227.GR13836@suse.de> <20040820173850.652694ba.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040820173850.652694ba.sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20 2004, Stephen Rothwell wrote:
> Hi Andrew,
> 
> This patch adds the ability to use DVD-RAM drives to the iSeries virtual
> cdrom driver.  This version adresses (hopefully) Jens comments on the
> previous one.
> 
> The patch is against 2.6.8.1 but sould apply to just about anything. 
> Please apply to your tree and Linus'.  There is no clash with the patches
> that Paulus has been sending you.

Looks fine.

-- 
Jens Axboe


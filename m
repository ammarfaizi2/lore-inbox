Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965174AbVLVSNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965174AbVLVSNM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 13:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965175AbVLVSNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 13:13:11 -0500
Received: from 213-140-2-73.ip.fastwebnet.it ([213.140.2.73]:6613 "EHLO
	aa006msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S965172AbVLVSNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 13:13:09 -0500
Date: Thu, 22 Dec 2005 19:13:34 +0100
From: Mattia Dongili <malattia@linux.it>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc5-mm3
Message-ID: <20051222181333.GA4572@inferi.kami.home>
Mail-Followup-To: Jesper Juhl <jesper.juhl@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20051214234016.0112a86e.akpm@osdl.org> <9a8748490512211514g62bec66dqfb00b4dc1aeb7628@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490512211514g62bec66dqfb00b4dc1aeb7628@mail.gmail.com>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.15-rc5-mm3-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 12:14:18AM +0100, Jesper Juhl wrote:
> On 12/15/05, Andrew Morton <akpm@osdl.org> wrote:
> >
> <!-- snip -->
> >
> > -mm-implement-swap-prefetching.patch
> > -mm-implement-swap-prefetching-default-y.patch
> > -mm-implement-swap-prefetching-tweaks.patch
> > -mm-implement-swap-prefetching-tweaks-2.patch
> > -mm-swap-prefetch-magnify.patch
> >
> >  Dropped swap prefetching, sorry.  I wasn't able to notice much benefit from
> >  it in my testing, and the number of mm/ patches in getting crazy, so we don't
> >  have capacity for speculative things at present.
> >
> <!-- snip -->
> 
> This is a bit sad.

same feeling for me.
I did not notice Andrew's log saying he dropped the patch in the first
place but I noticed a slower reaction time (in similar conditions as
Jesper) that lead me to the absence of swap prefetching in -mm3.
PIII-M 1GHz + 256M Ram + 256M swap here.

-- 
mattia
:wq!

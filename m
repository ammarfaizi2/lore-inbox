Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269087AbUJKQo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269087AbUJKQo5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 12:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269247AbUJKQop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 12:44:45 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56849 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S269134AbUJKQfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 12:35:33 -0400
Date: Mon, 11 Oct 2004 18:35:01 +0200
From: Adrian Bunk <bunk@stusta.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] 2.6.9-rc4: SCSI qla2xxx gcc 3.4 compile errors
Message-ID: <20041011163501.GB3485@stusta.de>
References: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org> <20041011162457.GA3485@stusta.de> <1097512128.1714.128.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097512128.1714.128.camel@mulgrave>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 11:28:42AM -0500, James Bottomley wrote:
> On Mon, 2004-10-11 at 11:24, Adrian Bunk wrote:
> > Please apply my patch below which is already for some time in James' 
> > SCSI tree.
> 
> It's waiting in my tree until 2.6.9 goes final because gcc-3.4 fixes are
> hardly showstoppers.  If you want to compile the kernel with gcc-3.4 use
> -mm

It's the only compile error with gcc 3.4 I found in 2.6.9-rc4, and the 
fix is pretty low-risk.

> James

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWAVI0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWAVI0c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 03:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWAVI0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 03:26:32 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53726 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751260AbWAVI0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 03:26:31 -0500
Date: Sun, 22 Jan 2006 09:26:20 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Shaun Savage <savages@tvlinux.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: CBD Compressed Block Device, New embedded block device
Message-ID: <20060122082620.GC1543@elf.ucw.cz>
References: <43D3467C.7010803@tvlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D3467C.7010803@tvlinux.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 22-01-06 00:46:52, Shaun Savage wrote:
> HI
> 
> Here is a patch for 2.6.14.5 of CBD
> CBD is a compressed block device that is designed to shrink the file 
> system size to 1/3 the original size.  CBD is a block device on a file 
> system so, it also allows for in-field upgrade of file system.  If 
> necessary is also allows for secure booting, with a GRUB patch.

What does compression have to do with secure booting?


-- 
Thanks, Sharp!

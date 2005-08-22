Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbVHVWLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbVHVWLT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbVHVWLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:11:19 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:53638 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751055AbVHVWLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:11:17 -0400
Date: Mon, 22 Aug 2005 13:46:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Hellwig <hch@infradead.org>,
       "Machida, Hiroyuki" <machida@sm.sony.co.jp>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Posix file attribute support on VFAT (take #2)
Message-ID: <20050822114629.GA29046@elf.ucw.cz>
References: <43023957.1020909@sm.sony.co.jp> <20050816212531.GA2479@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050816212531.GA2479@infradead.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This is a take 2 of posix file attribute support on VFAT.
> 
> Sorry, but this is far too scary.  Please just use one of the sane
> filesystems linux supports.

Unfortunately, it makes sense. If you have compact flash card, you
really want to have VFAT there, so that it is a) compatible with
windows and b) so that you don't kill the hardware.

I guess being able to use CF card for root filesystem is usefull,
too....

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address

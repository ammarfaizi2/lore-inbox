Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276877AbRKVKmB>; Thu, 22 Nov 2001 05:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276982AbRKVKlr>; Thu, 22 Nov 2001 05:41:47 -0500
Received: from [194.213.32.133] ([194.213.32.133]:33665 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S276877AbRKVKlJ>;
	Thu, 22 Nov 2001 05:41:09 -0500
Date: Wed, 21 Nov 2001 00:42:59 +0000
From: Pavel Machek <pavel@suse.cz>
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] AMD SMP capability sanity checking.
Message-ID: <20011121004258.B37@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.30.0111162219170.22827-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.30.0111162219170.22827-100000@Appserv.suse.de>; from davej@suse.de on Fri, Nov 16, 2001 at 10:30:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> In the wake of the recent fallout of "are Athlon XP's SMP capable or not",
> the following patch adds some sanity checking to the SMP boot up code.
> This code is based upon information from the folks at AMD. There are
> no exceptions to these rules.

Are there public errata documents which say what's wrong with older
athlons? Without that info I think this patch is bad idea.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.


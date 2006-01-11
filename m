Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751619AbWANJeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbWANJeQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 04:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbWANJeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 04:34:16 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19975 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751546AbWANJd4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 04:33:56 -0500
Date: Wed, 11 Jan 2006 20:37:32 +0000
From: Pavel Machek <pavel@suse.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: Tim Tassonis <timtas@cubic.ch>, linux-kernel@vger.kernel.org
Subject: Re: State of the Union: Wireless
Message-ID: <20060111203731.GF2456@ucw.cz>
References: <43C3AAE2.1090900@cubic.ch> <20060110125357.GH3911@stusta.de> <43C3B7C8.8000708@cubic.ch> <20060110141324.GJ3911@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110141324.GJ3911@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Like the OSS/Alsa or XFree3.x/XFree4.x situations.
> 
> And OSS/ALSA is an example why this is not a good thing:
> - OSS in the kernel is unmaintained
> - people forced to use OSS drivers can't use applications only 
>   supporting ALSA

Well, it is different. Current ieee80211 stack is going to be
maintained by Intel -- because they need it for their hw.
And it will be very easy to find maintainer for the new stack...

So we already have two-stack situation here.

-- 
Thanks, Sharp!

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbVLVAPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbVLVAPE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 19:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbVLVAPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 19:15:04 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:11789 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965019AbVLVAPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 19:15:03 -0500
Date: Thu, 22 Dec 2005 01:15:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Input: fix an OOPS in HID driver
Message-ID: <20051222001501.GI3917@stusta.de>
References: <200512162131.04544.dtor_core@ameritech.net> <20051217102223.GB27280@midnight.suse.cz> <200512171140.28029.dtor_core@ameritech.net> <200512171142.54758.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512171142.54758.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2005 at 11:42:54AM -0500, Dmitry Torokhov wrote:

> This patch fixes an OOPS in HID driver when connecting simulation
> devices generating unknown simulation events.
>...

This patch now went into Linus' tree.

It seems this patch should also go into 2.6.14.5?
If you agree, please submit it to stable@kernel.org .

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


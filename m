Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965224AbWEaWuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965224AbWEaWuA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 18:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965223AbWEaWt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 18:49:59 -0400
Received: from mail.tmr.com ([64.65.253.246]:1449 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S965226AbWEaWt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 18:49:59 -0400
Message-ID: <447E1E04.5060509@tmr.com>
Date: Wed, 31 May 2006 18:51:48 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.2) Gecko/20060405 SeaMonkey/1.0.1
MIME-Version: 1.0
To: Nuri Jawad <lkml@jawad.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Source Compression
References: <Pine.LNX.4.64.0605211028100.4037@p34> <200605222015.01980.s0348365@sms.ed.ac.uk> <Pine.LNX.4.61.0605222220190.6816@yvahk01.tjqt.qr> <200605222200.18351.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0605230407320.25860@pc>
In-Reply-To: <Pine.LNX.4.64.0605230407320.25860@pc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nuri Jawad wrote:
> Hi,
> just wanted to remark that I never liked that bzip was replaced by bzip2 
> (were there license issues?) since bzip's compression was/is often 
> stronger:
> 
> 39843104 Mar 28 09:33 linux-2.6.15.7.tar.bz2
> 39423739 Mar 28 09:33 linux-2.6.15.7.tar.bz
> 
> Not a big difference in this case but still a step back. I for once am 
> keeping my bzip binary.. does anyone know where the source can still be 
> found?

I know I have a copy backed up, but I'm rather disorganized at the 
moment, having moved two out-of-town offices into this one, after 
spending 12 years on a ten week contract... but I doubt you want it, 
it's slow as hell and violates all manner of patents. Mind you, I think 
the patents are held by IBM, so they might be negotiable, but I think 
the original is dead. Used either fractal or arithmetic compression IIRC.
-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.


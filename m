Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbUGLTgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUGLTgS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 15:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUGLTgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 15:36:12 -0400
Received: from smtp.loomes.de ([212.40.161.2]:19691 "EHLO falcon.loomes.de")
	by vger.kernel.org with ESMTP id S261867AbUGLTgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 15:36:05 -0400
From: Sebastian Slota <sebastian@sslota.de>
To: linux-kernel@vger.kernel.org
Subject: Re: SiI SATA kernel driver
Date: Mon, 12 Jul 2004 21:35:59 +0200
User-Agent: KMail/1.6.2
References: <3254.1089628481@www2.gmx.net>
In-Reply-To: <3254.1089628481@www2.gmx.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407122135.59081.sebastian@sslota.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

As far as I know ( using Sil 3114) the driver is called medley. its for 2.4 
kernels and included in 2.4.27 (?) google for it and you'll find it.
Its a kind of software raid anyway...

For 2.6 kernels there should be used dm or md (dont know which).

Anyway I've tested linux software raid and have to tell that Raid0 is far 
better with linux raid0!  (if you got the right HDs!). Raid1 is the same.
You've nothing to gain using ~Sil Raid~!
Only when you have a Win system installed there too you'll have to use it!

My advise: Use Linux Software Raid! far better documented!!!

Tool I use: mdadm ( google for it if its not included in your distri! )

Sebastian


On Monday 12 July 2004 12:34, Markus Nicolussi wrote:
> please can u help me with this problem:
>
> can u tell me if the driver supports the SiI3112 Chip in _RAID_mode_? Or
> ist there a website which is constantly updated where i can look to from
> time to time and which tells me that?
>
> merci, nico.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

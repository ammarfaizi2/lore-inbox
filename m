Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266205AbUALPyP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 10:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266223AbUALPyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 10:54:14 -0500
Received: from mail46-s.fg.online.no ([148.122.161.46]:20979 "EHLO
	mail46.fg.online.no") by vger.kernel.org with ESMTP id S266205AbUALPyI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 10:54:08 -0500
To: Jaroslav Kysela <perex@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] ALSA 1.0.1
References: <Pine.LNX.4.58.0401082059300.13704@pnote.perex-int.cz>
From: Harald Arnesen <harald@skogtun.org>
Date: Mon, 12 Jan 2004 16:53:54 +0100
In-Reply-To: <Pine.LNX.4.58.0401082059300.13704@pnote.perex-int.cz> (Jaroslav
 Kysela's message of "Thu, 8 Jan 2004 21:15:07 +0100 (CET)")
Message-ID: <87ptdpf9il.fsf@basilikum.skogtun.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaroslav Kysela <perex@suse.cz> writes:

> Hello all,
>
> The ALSA 1.0.1 code for 2.6 kernels is available. I think that this update
> might be included into -mm or standard 2.6 kernels.
>
>   - ICE1712 driver updated

Still doesn't work on my TerraTec 6fire LT.

>From dmesg after "modprobe snd-1712":

request_module: failed /sbin/modprobe -- snd-card-0. error = 256
unable to send register 0x7f byte to CS8427
unable to find CS8427 signature (expected 0x71, read 0xfffffffb), initialization is not completed
CS8427 initialization failed
ICE1712: probe of 0000:00:11.0 failed with error -14
-- 
Hilsen Harald.

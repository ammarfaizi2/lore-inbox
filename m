Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbVC1PGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVC1PGe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 10:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVC1PGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 10:06:31 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:17378 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261837AbVC1PG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 10:06:28 -0500
Date: Mon, 28 Mar 2005 17:06:13 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ara Avanesyan <araav@hylink.am>
cc: linux-kernel@vger.kernel.org, avila@lists.unixstudios.net
Subject: Re: Strange memory problem with Linux booted from U-Boot
In-Reply-To: <00ae01c533a6$85ddf1f0$1000000a@araavanesyan>
Message-ID: <Pine.LNX.4.61.0503281705230.16973@yvahk01.tjqt.qr>
References: <006b01c5047e$1efc78a0$1000000a@araavanesyan>
 <20050127144441.GB4848@home.fluff.org> <00ae01c533a6$85ddf1f0$1000000a@araavanesyan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>
>I need some help on solving this strange problem.
>Here is what I have,
>I have a loadable module (linux.2.4.20) which contains a 2 mb static gloabal
>array.
>
>Additional information:
>The same error occurs if I just run depmod -a.

I'd be more interested in the kernel space code...



Jan Engelhardt
-- 
No TOFU for me, please.

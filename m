Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbTLQMZi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 07:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264388AbTLQMZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 07:25:38 -0500
Received: from cibs9.sns.it ([192.167.206.29]:1287 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id S264373AbTLQMZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 07:25:36 -0500
Date: Wed, 17 Dec 2003 13:25:34 +0100 (CET)
From: venom@sns.it
To: "J.A. Magallon" <jamagallon@able.es>
cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: gcc-3.3.2 vs 2.6.0-test11
In-Reply-To: <20031217113742.GC2074@werewolf.able.es>
Message-ID: <Pine.LNX.4.43.0312171324380.32480-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


using gcc 3.3.2 with 2.6.0-test11 and 2.4.23. boots cleanly on Ayhlon XP,
Athlon-trbind, PentiumIII.

which compilation options are you using?

Luigi

On Wed, 17 Dec 2003, J.A. Magallon wrote:

> Date: Wed, 17 Dec 2003 12:37:42 +0100
> From: J.A. Magallon <jamagallon@able.es>
> To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
> Subject: gcc-3.3.2 vs 2.6.0-test11
>
> hi all..
>
> Are there any known issues wrt gcc-3.3.2 ?
> I built test11 with gcc-3.3.1 and worked fine, the same config built with
> 3.3.2 does not pass init launch:
>
> INIT version 2.85 booting
>
> and nothing more....
>
> I have to check, but I think it also miscompiles 2.4. I rebuilt a kernel on a
> remote box (2.4.23 + assorted patches), that worked fine under 3.3.1, and
> after reboot the box didn't came to life, no ping.
>
> TIA
>
> --
> J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
> werewolf!able!es                         \           It's better when it's free
> Mandrake Linux release 10.0 (Cooker) for i586
> Linux 2.6.0-test11-jam2 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-4mdk))
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


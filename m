Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267106AbRGOWsa>; Sun, 15 Jul 2001 18:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267107AbRGOWsU>; Sun, 15 Jul 2001 18:48:20 -0400
Received: from Expansa.sns.it ([192.167.206.189]:58375 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S267106AbRGOWsM>;
	Sun, 15 Jul 2001 18:48:12 -0400
Date: Mon, 16 Jul 2001 00:47:56 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: <lk@Aniela.EU.ORG>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Problems with an older card on XFree86
In-Reply-To: <Pine.LNX.4.33.0107160620210.564-100000@ns1.Aniela.EU.ORG>
Message-ID: <Pine.LNX.4.33.0107160044100.19611-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 16 Jul 2001 lk@Aniela.EU.ORG wrote:

> Hi,
>
>         First off all I want to apologize posting to this list, but I had
> no ideea where else to ask this question.
>
Maybe a XFree86 mail list would be a better address for your mail.

Anyway, you should go back ti XF 3.3.6, since your card is not supported
with XF 4.1.0, and you would get no
advanteges because your card does not support 3d acceleration, and 2d
acceleration with
XF86_S3 or even XF86_SVGA
of 3.3.6 version is quite optimal for your card.

bests
Luigi Genoni


>         I recently installed Slackware Linux 8.0 on my machine, but
> XFree86 does not work corectly. I managed to configure it, but it only
> runs is VESA mode because I found no driver for my card (S3 Trio64V2
> DX/GX). In all modes (640x480 and 800x600), about 2centimeters in the top
> area of the screen (2centimeters in height and all the screen in width)
> are remapped randomly on the screen. I'll try to explain this behaviour:
> If I open any aplication and then maximize it, when I try to reach the
> titlebar of the aplication, the mouse is moved in the lower part of the
> screen. It's just like the 2 centimeters that are not shown in the upper
> part of the screen are redrawn in the lower part. Is there any solution to
> this, or I'll have to switch back to 3.3.6 to get my card working again ?
>
>
>
> Eugen
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


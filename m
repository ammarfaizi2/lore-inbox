Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143645AbRAHNQK>; Mon, 8 Jan 2001 08:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143595AbRAHNQA>; Mon, 8 Jan 2001 08:16:00 -0500
Received: from pop.gmx.net ([194.221.183.20]:59197 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S143575AbRAHNP4>;
	Mon, 8 Jan 2001 08:15:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: Cajus Pollmeier <C.Pollmeier@gmx.net>
To: "Mohammad A. Haque" <mhaque@haque.net>, "Karl O. Pinc" <kop@meme.com>
Subject: Re: Bug: Frame-buffer (icon) rotates right in 2.4.0 when SMP
Date: Mon, 8 Jan 2001 11:26:29 +0100
X-Mailer: KMail [version 1.2]
Cc: "<linux-kernel@vger.kernel.org>" <lpp@freelords.org>
In-Reply-To: <Pine.LNX.4.30.0101072157330.17399-100000@viper.haque.net>
In-Reply-To: <Pine.LNX.4.30.0101072157330.17399-100000@viper.haque.net>
MIME-Version: 1.0
Message-Id: <01010811262903.00883@quark>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag,  8. Januar 2001 04:00 schrieb Mohammad A. Haque:
> when you use SMP there's suppOsed to be one icon that shows up for
> every CPU you have. 2 cpu = 2 icons, 4 cpu = 4 icon. That's what the for
> loop in fbcon_show_logo().
>
> So this really isnt a bug, depending on how you look at it. It's
> definitely something the lpp author needs to account for.

It is already fixed in the new (not yet released) version.

-Cajus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

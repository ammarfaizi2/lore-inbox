Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136324AbRA2LOg>; Mon, 29 Jan 2001 06:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136411AbRA2LO0>; Mon, 29 Jan 2001 06:14:26 -0500
Received: from agsite2.demon.co.uk ([212.229.103.106]:62213 "EHLO
	gateway.agsite2.demon.co.uk") by vger.kernel.org with ESMTP
	id <S136324AbRA2LOL>; Mon, 29 Jan 2001 06:14:11 -0500
Message-ID: <3A75507A.9386AFE2@agelectronics.co.uk>
Date: Mon, 29 Jan 2001 11:14:02 +0000
From: Adrian Cox <apc@agelectronics.co.uk>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dylan Griffiths <Dylan_G@bigfoot.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: More on the VIA KT133 chipset misbehaving in Linux
In-Reply-To: <3A75278F.B41B492B@bigfoot.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dylan Griffiths wrote:
> The VIA KT133 chipset exhibits the following bugs under Linux 2.2.17 and
> 2.4.0:
> 1) PS/2 mouse cursor randomly jumps to upper right hand corner of screen and
> locks for a bit

This happens to me about once a month on a BX chipset PII machine here,
and on a KT133 chipset machine I have.  I have to hit ctrl-alt-backspace
to regain control of the console. I always assumed it was a bug in X,
but it never caused me enough trouble to actually make me pursue it.

- Adrian
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

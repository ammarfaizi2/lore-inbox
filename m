Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129975AbRA2Lle>; Mon, 29 Jan 2001 06:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130164AbRA2LlZ>; Mon, 29 Jan 2001 06:41:25 -0500
Received: from agsite2.demon.co.uk ([212.229.103.106]:8198 "EHLO
	gateway.agsite2.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129975AbRA2LlJ>; Mon, 29 Jan 2001 06:41:09 -0500
Message-ID: <3A7556C6.5A9518FA@agelectronics.co.uk>
Date: Mon, 29 Jan 2001 11:40:54 +0000
From: Adrian Cox <apc@agelectronics.co.uk>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: safemode <safemode@voicenet.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: More on the VIA KT133 chipset misbehaving in Linux
In-Reply-To: <3A75278F.B41B492B@bigfoot.com> <3A75507A.9386AFE2@agelectronics.co.uk> <3A75546F.DAC87368@voicenet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

safemode wrote:
> Adrian Cox wrote:
> > Dylan Griffiths wrote:
> > > 1) PS/2 mouse cursor randomly jumps to upper right hand corner of screen and
> > > locks for a bit
> > This happens to me about once a month on a BX chipset PII machine here,
> > and on a KT133 chipset machine I have.  I have to hit ctrl-alt-backspace
> > to regain control of the console. I always assumed it was a bug in X,
> > but it never caused me enough trouble to actually make me pursue it.
> turn off gpm..   fixes the mouse problem immediately.   as in killall -9 gpm
> before starting X.

I don't even have gpm installed on these machines, precisely for this
reason. Whatever it is, it isn't gpm. But I also believe it isn't Via,
and I'm not convinced that it's the kernel.

- Adrian Cox
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

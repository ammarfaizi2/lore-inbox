Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130164AbRA2Lsm>; Mon, 29 Jan 2001 06:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130330AbRA2Lsd>; Mon, 29 Jan 2001 06:48:33 -0500
Received: from rasputin.trustix.com ([195.139.104.66]:773 "HELO
	rasputin.trustix.com") by vger.kernel.org with SMTP
	id <S130164AbRA2LsP>; Mon, 29 Jan 2001 06:48:15 -0500
Message-ID: <3A75589D.3011F759@trustix.com>
Date: Mon, 29 Jan 2001 12:48:45 +0100
From: Lars Gaarden <larsg@trustix.com>
Organization: Trustix AS
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adrian Cox <apc@agelectronics.co.uk>
Cc: Dylan Griffiths <Dylan_G@bigfoot.com>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: More on the VIA KT133 chipset misbehaving in Linux
In-Reply-To: <3A75278F.B41B492B@bigfoot.com> <3A75507A.9386AFE2@agelectronics.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Cox wrote:
> 
> Dylan Griffiths wrote:
> > The VIA KT133 chipset exhibits the following bugs under Linux 2.2.17 and
> > 2.4.0:
> > 1) PS/2 mouse cursor randomly jumps to upper right hand corner of screen and
> > locks for a bit
> 
> This happens to me about once a month on a BX chipset PII machine here,
> and on a KT133 chipset machine I have.  I have to hit ctrl-alt-backspace
> to regain control of the console. I always assumed it was a bug in X,
> but it never caused me enough trouble to actually make me pursue it.

Useless datapoint:
I've experienced the same a few times on an old Pentium computer.
Mouse pointer jumps to upper right corner, and locks hard.
Intel chipset, not sure if it is FX or HX. Matrox Mill2 graphics card.
Kernel is 2.2.16-ish on a modified RH6.1. XFree 3.3.6. gpm is running.

-- 
LarsG
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.com) by vger.kernel.org via listexpand
	id <S261151AbRELD7s>; Fri, 11 May 2001 23:59:48 -0400
Received: (majordomo@vger.kernel.com) by vger.kernel.org
	id <S261154AbRELD7L>; Fri, 11 May 2001 23:59:11 -0400
Received: from zeus.kernel.org ([209.10.41.242]:49800 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261171AbRELD6N>;
	Fri, 11 May 2001 23:58:13 -0400
Message-ID: <0c5201c0da9a$4d736200$7dad0f18@Nick>
From: "Nick Long" <nicklong@home.com>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "kernel" <linux-kernel@vger.kernel.org>,
        "Tim Moore" <timothymoore@bigfoot.com>
In-Reply-To: <Pine.LNX.4.05.10105110944520.1624-100000@callisto.of.borg>
Subject: Re: ncr53c8xx - DAT detection problem - 2.2.14-5
Date: Fri, 11 May 2001 21:16:21 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert,  I have "CONFIG_CHR_DEV_ST=y" in my "/usr/src/linux/.config" file.
Any ideas?

----- Original Message -----
From: "Geert Uytterhoeven" <geert@linux-m68k.org>
To: <nicklong@home.com>
Cc: "kernel" <linux-kernel@vger.kernel.org>
Sent: Friday, May 11, 2001 12:45 AM
Subject: Re: ncr53c8xx - DAT detection problem - 2.2.14-5


> On Thu, 10 May 2001, Tim Moore wrote:
> > Any clues as to why /dev/st0 is never initialized for DAT tape?  Please
cc nicklong@home.com if more
> > info is needed.
>
> Make sure CONFIG_CHR_DEV_ST=[ym]
>
> Gr{oetje,eeting}s,
>
> Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker.
But
> when I'm talking to journalists I just say "programmer" or something like
that.
>     -- Linus Torvalds
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261717AbSJNOfX>; Mon, 14 Oct 2002 10:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261728AbSJNOfX>; Mon, 14 Oct 2002 10:35:23 -0400
Received: from ginsberg.uol.com.br ([200.221.4.48]:11137 "EHLO
	ginsberg.uol.com.br") by vger.kernel.org with ESMTP
	id <S261717AbSJNOfW>; Mon, 14 Oct 2002 10:35:22 -0400
Date: Mon, 14 Oct 2002 11:42:01 -0200
From: Andre Costa <brblueser@uol.com.br>
To: DervishD <raul@pleyades.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Known 'issues' about 2.4.19...
Message-Id: <20021014114201.493c812a.brblueser@uol.com.br>
In-Reply-To: <20021013184052.GC46@DervishD>
References: <20021013184052.GC46@DervishD>
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raúl,

I've been using 2.4.19 for a couple of months already. Generally
speaking, I've had no probls with it. I recently found out its IDE
subsystem doesn't get along too well with VIA chipsets (replaced my old
mobo for a VT8233 based recently and probls started surfacing).
Basically, I am unable to rip audio tracks from my cds
(/var/log/messages logs a lot of timeouts).

This is a real PITA, but kernel folks are already aware of it and and
it's going through major reimplementation on 2.5.x branch, AFAIK. Also,
I've seen increasing activity on VIA's Linux forums (this issue has
surfaced a couple of times there as well), so there's hope VIA might
start working closer to the Linux community.

Aside from this, I've been using it daily at home, for all sorts of
things.

HTH,

Andre

On Sun, 13 Oct 2002 20:40:52 +0200
DervishD <raul@pleyades.net> wrote:

>     Hi all :))
> 
>     Is there any known bug or other issues about 2.4.19 that prevents
> it from being used in a production machine? I mean, I don't worry if
> the sound is broken or things like those, I mean if the IDE driver
> does 'things' and the like ;))
> 
>     I'm thinking about going to 2.4.19 or the latest -ac for 2.4.20.
> 
>     Thanks a lot :)
>     Raúl
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Andre Oliveira da Costa

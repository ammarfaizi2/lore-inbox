Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131576AbRABU2p>; Tue, 2 Jan 2001 15:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131598AbRABU2e>; Tue, 2 Jan 2001 15:28:34 -0500
Received: from cs75251.pp.htv.fi ([212.90.75.251]:9969 "EHLO
	chip.nutshakers.dhs.org") by vger.kernel.org with ESMTP
	id <S131576AbRABU2X>; Tue, 2 Jan 2001 15:28:23 -0500
Date: Tue, 2 Jan 2001 21:56:40 +0200 (EET)
From: Panu Matilainen <pmatilai@pp.htv.fi>
To: J Sloan <jjs@toyota.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Compile errors: RCPCI, LANE, and others
In-Reply-To: <3A522432.64FF7B7E@toyota.com>
Message-ID: <Pine.LNX.4.30.0101022152550.2107-100000@chip.nutshakers.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2001, J Sloan wrote:
> Alan Cox wrote:
>
> > Bzzt, wrong. Red Hat 7 compiles the 2.4 tree beautifully with gcc 2.96 as well.
> > Please grow up.
>
> Yes indeed - on my quad CPU Red Hat 7 server, I accidentally
> forgot to say CC=kgcc during the last kernel build, and ended
> up with a gcc-2.96 built kernel. I decided to let it run and see
> what happens - It's been up and running -test12 for about 20
> days now, solid as a rock.

Same here, forgot to do CC=kgcc when compiling 2.4-prerelease and my PIII
box is running happily (only 1.5 days uptime at the point but...) Compiled
with the errata gcc 2.96.

	- Panu -

>
> My home system, an AMD k6, likewise is very very happy
> running 2.4.0-prerelase compiled with gcc 2.96
>
> jjs
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-- 
	- Panu -

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

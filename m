Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262554AbRENXL4>; Mon, 14 May 2001 19:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262563AbRENXLq>; Mon, 14 May 2001 19:11:46 -0400
Received: from anime.net ([63.172.78.150]:53010 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S262554AbRENXLd>;
	Mon, 14 May 2001 19:11:33 -0400
Date: Mon, 14 May 2001 16:11:16 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <E14zRFZ-0001dI-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0105141609460.15073-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 May 2001, Alan Cox wrote:
> grep MAJOR lilo-21.4.4/*|wc -l
>     323
> Also hdparm
> raidtools
> psmisc
> mtools
> mt-st
> gpm
> joystick

so we now have a list of stuff that needs to be fixed 8)

or at least, a cross section sampling of stuff to design a new API for.

-Dan


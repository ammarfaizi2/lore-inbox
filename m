Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S263125AbUJ2HYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbUJ2HYG (ORCPT <rfc822;akpm@zip.com.au>);
	Fri, 29 Oct 2004 03:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263127AbUJ2HYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 03:24:06 -0400
Received: from apate.telenet-ops.be ([195.130.132.57]:56254 "EHLO
	apate.telenet-ops.be") by vger.kernel.org with ESMTP
	id S263125AbUJ2HXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 03:23:41 -0400
Date: Fri, 29 Oct 2004 09:23:56 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Andrew Morton <akpm@osdl.org>, castet.matthieu@free.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: fw :[patch] i810 TCO TIMER WATCHDOG request region fix
Message-ID: <20041029072356.GL9674@infomag.infomag.iguana.be>
References: <20041021014339.6f74df56.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041021014339.6f74df56.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthieu,

Sorry for the late response.
I'll itest it and add this to the linux-2.6-watchdog-mm bitkeeper tree tonight.

Greetings,
Wim.

> Date: Wed, 20 Oct 2004 21:38:48 +0200
> From: castet.matthieu@free.fr
> To: linux-kernel@vger.kernel.org
> Subject: fw :[patch] i810 TCO TIMER WATCHDOG request region fix
> 
> 
> Hi,
> I sent this patch more than 1 month ago to the i810 tco maintainer. Since I have
> no reply, I forward it to the lkml.
> 
> Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
> 
> ----- Message transféré de castet.matthieu@free.fr -----
>    Date : Sat, 28 Aug 2004 22:33:32 +0200
>      De : castet.matthieu@free.fr
> Adresse de retour :castet.matthieu@free.fr
>   Sujet : i810 TCO TIMER WATCHDOG resuaest region fix
>       À : nils@kernelconcepts.de
> 
> Hello,
> in i8xx_tco.c, during the initialisation, the driver make io without checking if
> the port is free.
> 
> Patch attach.
> 
> Thanks
> 
> Matthieu
> ----- Fin du message transféré -----


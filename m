Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267469AbUGWQHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267469AbUGWQHk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 12:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267830AbUGWQHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 12:07:05 -0400
Received: from web52906.mail.yahoo.com ([206.190.39.183]:43698 "HELO
	web52906.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267804AbUGWPuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 11:50:46 -0400
Message-ID: <20040723155045.19770.qmail@web52906.mail.yahoo.com>
Date: Fri, 23 Jul 2004 17:50:45 +0200 (CEST)
From: =?iso-8859-1?q?szonyi=20calin?= <caszonyi@yahoo.com>
Subject: Re: New dev model (was [PATCH] delete devfs)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Jackson <pj@sgi.com>, Adrian Bunk <bunk@fs.tum.de>,
       Andrew Morton <akpm@osdl.org>, corbet@lwn.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.58.0407231652050.9434@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Geert Uytterhoeven <geert@linux-m68k.org> a écrit : > On
Fri, 23 Jul 2004, [iso-8859-1] szonyi calin wrote:
> > And with new devepment model this expenses will be passed to
> the
> > end user when the kernel will not be stable enough and will
> >  crash. Do you you remember the 8k vs 4k stack problem for
> > Nvidia binary kernel module ?
> 
> You want a stable kernel, but you also want to rely on
> binary-only kernel
> modules?
> 

No. I wasn't clear on that one. My example was wrong. AFAIK the
8k/4k stack kernel problem were causing problems for other 
people too.

> The Linux kernel people cannot guarantee stability with
> binary-only kernel
> modules. And the Linux kernel people cannot solve that
> problem...
> 

I underestand that. 
However hpa told me that the stability of the 2.6 kernel will 
not suffer.

> Gr{oetje,eeting}s,
> 
> 						Geert
> 

Calin

=====
--
A mouse is a device used to point at 
the xterm you want to type in.
Kim Alm on a.s.r.


	

	
		
Vous manquez d’espace pour stocker vos mails ? 
Yahoo! Mail vous offre GRATUITEMENT 100 Mo !
Créez votre Yahoo! Mail sur http://fr.benefits.yahoo.com/

Le nouveau Yahoo! Messenger est arrivé ! Découvrez toutes les nouveautés pour dialoguer instantanément avec vos amis. A télécharger gratuitement sur http://fr.messenger.yahoo.com

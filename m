Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265130AbUD3JcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265130AbUD3JcM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 05:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265131AbUD3JcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 05:32:12 -0400
Received: from witte.sonytel.be ([80.88.33.193]:45192 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265130AbUD3JcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 05:32:11 -0400
Date: Fri, 30 Apr 2004 11:31:49 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marc Boucher <marc@linuxant.com>
cc: Sean Estabrooks <seanlkml@rogers.com>, koke@sindominio.net,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Wagland <paul@wagland.net>, Rusty Russell <rusty@rustcorp.com.au>,
       Rik van Riel <riel@redhat.com>,
       David Gibson <david@gibson.dropbear.id.au>,
       Linus Torvalds <torvalds@osdl.org>,
       Timothy Miller <miller@techsource.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
In-Reply-To: <3A39091E-9A4C-11D8-B83D-000A95BCAC26@linuxant.com>
Message-ID: <Pine.GSO.4.58.0404301130040.8585@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0404291114150.9152-100000@chimarrao.boston.redhat.com>
 <4FE43C97-9A20-11D8-B804-000A95CD704C@wagland.net> <4091757B.3090209@techsource.com>
 <200404292347.17431.koke_lkml@amedias.org> <0CAE0144-9A2C-11D8-B83D-000A95BCAC26@linuxant.com>
 <20040429195553.4fba0da7.seanlkml@rogers.com> <3A39091E-9A4C-11D8-B83D-000A95BCAC26@linuxant.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2004, Marc Boucher wrote:
> However we also believe that pragmatically bringing in support for key
                               ^^^^^^^^^^^^^
> hardware (which currently cannot otherwise be easily handled in the
> traditional open-source approach) will benefit Linux, help it gain even
> more usefulness/acceptance, and make larger numbers of exposed people
> realize the natural advantages of open-source, then become
> contributors. On the other hand, forcing open-source down throats with
> impractical "tainting" schemes, scare tactics or other coercive methods
  ^^^^^^^^^^^
> may achieve the opposite effect or turn Linux into just an
> ideological/political movement rather than the ubiquitous operating
> system it deserves to be.

While tainting is not merely a political scheme, but mainly a _practical_
one...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

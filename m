Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266096AbRF2OeM>; Fri, 29 Jun 2001 10:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266094AbRF2Odw>; Fri, 29 Jun 2001 10:33:52 -0400
Received: from ip116.gte31.rb1.bel.nwlink.com ([207.202.209.116]:3127 "EHLO
	lily.altaserv.net") by vger.kernel.org with ESMTP
	id <S266096AbRF2Odr>; Fri, 29 Jun 2001 10:33:47 -0400
Date: Fri, 29 Jun 2001 07:33:40 -0700 (PDT)
From: Chuck Wolber <chuckw@altaserv.net>
X-X-Sender: <chuckw@localhost.localdomain>
To: Kai Henningsen <kaih@khms.westfalen.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Cosmetic JFFS patch.
In-Reply-To: <83lrQramw-B@khms.westfalen.de>
Message-ID: <Pine.LNX.4.33.0106290730540.19843-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Does sed tell you who programmed it on startup?
>
> Awk?
>
> Perl?
>
> Groff?
>
> Gcc?
>
> See a pattern here?

Yeah, the output of these programms are usually parsed by other programs.
If they barked version info, that'd be extra code that has to go into
*EVERY* script that uses them. You're not using the kernel in the same
capacity.


-- 
Chuck Wolber		| steward: "Are you the pilot?"
System Administrator	| pilot: "Yes, why?"
AltaServ Corporation	| steward, handing box to pilot: "Then this is for you."
(425)576-1202		| pilot, looking inside box: "Oh, it's a new altimeter."
ten.vresatla@wkcuhc	| 	--Chris Kennedy


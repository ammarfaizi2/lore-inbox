Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266680AbUGVCwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266680AbUGVCwa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 22:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266683AbUGVCwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 22:52:30 -0400
Received: from 214.98-30-64.ftth.swbr.surewest.net ([64.30.98.214]:53511 "HELO
	sublime.the-space.net") by vger.kernel.org with SMTP
	id S266680AbUGVCw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 22:52:29 -0400
Date: Wed, 21 Jul 2004 19:53:13 -0700 (PDT)
From: Andy Biddle <andyb@chainsaw.com>
X-X-Sender: andyb@sublime.winfirst.com
To: linux-kernel@vger.kernel.org
Subject: Re: Asus A7M266-D, Linux 2.6.7 and APIC
In-Reply-To: <200407211640.i6LGem6o025200@harpo.it.uu.se>
Message-ID: <20040721195120.J95088@sublime.winfirst.com>
References: <200407211640.i6LGem6o025200@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mikael,

You were absolutely right.  There was an update that I couldn't see from
the website.  Even better news is that it totally solved my problem.  No
APIC problems at all now!

Thanks a TON for the help!


On Wed, 21 Jul 2004, Mikael Pettersson wrote:

> On Wed, 21 Jul 2004 08:46:11 -0700 (PDT), Andy Biddle wrote:
> >Well I had a few minutes this morning, so I swapped CPU0 and 1 and still
> >have the same results.  Boots in single proc mode, APIC errors on a
> >dual-proc kernel.  (For what it's worth, both CPUs are recognized by the
> >BIOS and report "MP capable".
> >
> >I checked the Asus website and I'm at the latest beta kernel...
>
> No you're not. You have 1011.003, while the latest beta BIOS
> is 1011 beta 05.
>
> ftp.asuscom.de
> pub/ASUSCOM/BIOS/Socket_A/AMD_Chipset/AMD_760_MPX/A7M266-D/
>
>

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315259AbSEKX7Q>; Sat, 11 May 2002 19:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315261AbSEKX7P>; Sat, 11 May 2002 19:59:15 -0400
Received: from server0011.freedom2surf.net ([194.106.56.14]:45648 "EHLO
	server0011.freedom2surf.net") by vger.kernel.org with ESMTP
	id <S315259AbSEKX7O>; Sat, 11 May 2002 19:59:14 -0400
Date: Sun, 12 May 2002 01:07:09 +0100
From: Ian Molton <spyro@armlinux.org>
To: linux-kernel@vger.kernel.org
Subject: Changelogs on kernel.org
Message-Id: <20020512010709.7a973fac.spyro@armlinux.org>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.7.5cvs1 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi.

I dont know who to write to about this, but the changelogs for
2.4.19-pre on kernel.org are COMPLETELY illegible.

Can we 'tweak' them so that instead of:

<stelian@popies.net> (02/04/17 1.383.12.1)
	Fix meye driver request_irq bug.

<stelian@popies.net> (02/04/17 1.383.12.2)
	Enable the meye driver to get parameters on the kernel command line.

<akpm@zip.com.au> (02/04/17 1.383.13.1)
	[PATCH] add __LINE__ to out_of_line_bug()

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.2)
	[PATCH] PATCH: some configure.help updates

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.3)
	[PATCH] PATCH: more configure.help

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.4)
	[PATCH] PATCH: More configure.help

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.5)
	[PATCH] PATCH: more Configure.help

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.6)
	[PATCH] PATCH: maintainers update

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.7)
	[PATCH] PATCH: make cpu names clearer for new VIA


We get something nice like:

<stelian@popies.net>
   Fix meye driver request_irq bug.
   Enable the meye driver to get parameters on the kernel command line.

<akpm@zip.com.au>
   [PATCH] add __LINE__ to out_of_line_bug()

<alan@lxorguk.ukuu.org.uk>
   [PATCH] PATCH: some configure.help updates
   [PATCH] PATCH: more configure.help
   ... above repeated 2 times
   [PATCH] PATCH: maintainers update
   [PATCH] PATCH: make cpu names clearer for new VIA



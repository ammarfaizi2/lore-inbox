Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbTFOQ1F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 12:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbTFOQ1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 12:27:05 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:10192 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262362AbTFOQ1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 12:27:02 -0400
Date: Sun, 15 Jun 2003 18:40:46 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ben Collins <bcollins@debian.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: bkSVN live
In-Reply-To: <20030615133631.GF542@hopper.phunnypharm.org>
Message-ID: <Pine.GSO.4.21.0306151839170.14609-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Jun 2003, Ben Collins wrote:
> For those that know SVN, you need a recent (e.g. upcoming 0.24 release
> of SVN, or current trunk) client. I am using revision r6227. If you need

Can you confirm that 0.23.0 (r5962) (from Debian unstable) is too old, or is
this a PPC-specific problem?

| callisto$ svn co svn://kernel.bkbits.net/linux-2.5/trunk linux-2.5
| svn: Malformed network data
| svn: Malformed network data
| callisto$

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


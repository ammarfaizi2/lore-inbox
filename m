Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316579AbSFZN3e>; Wed, 26 Jun 2002 09:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316580AbSFZN3e>; Wed, 26 Jun 2002 09:29:34 -0400
Received: from bernstein.mrc-bsu.cam.ac.uk ([193.60.86.52]:35215 "EHLO
	bernstein.mrc-bsu.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S316579AbSFZN3d>; Wed, 26 Jun 2002 09:29:33 -0400
Date: Wed, 26 Jun 2002 14:29:25 +0100 (BST)
From: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
X-X-Sender: alastair@gerber
To: garana@uolsinectis.com.ar
cc: linux-kernel@vger.kernel.org
Subject: Re: athlon 800MHz (Via82*) - Pentium4 Intel D845WN
Message-ID: <Pine.GSO.4.44.0206261424060.17994-100000@gerber>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi - your Red Hat installation will have used the Athlon-optimised
kernel by default, so it will not boot on a non-Athlon machine. You will
probably need to boot from a boot floppy, mount your filesystems, and
install a new i686-optimised kernel RPM. Or compile your own kernel on
another machine and get it in there.

I can't immediately give you the full details - look at Red Hat's
documentation or other help on the web....

Cheers
Alastair                            .-=-.
__________________________________,'     `.
                                           \   www.mrc-bsu.cam.ac.uk
Alastair Stevens, Systems Management Team   \       01223 330383
MRC Biostatistics Unit, Cambridge UK         `=.......................


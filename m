Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267079AbSKWUiG>; Sat, 23 Nov 2002 15:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267081AbSKWUiF>; Sat, 23 Nov 2002 15:38:05 -0500
Received: from 208-135-136-018.customer.apci.net ([208.135.136.18]:34308 "EHLO
	blessed") by vger.kernel.org with ESMTP id <S267079AbSKWUiF>;
	Sat, 23 Nov 2002 15:38:05 -0500
Date: Sat, 23 Nov 2002 14:44:10 -0600 (CST)
From: Josh Myer <jbm@joshisanerd.com>
X-X-Sender: jbm@blessed
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Tridentfb updates?
In-Reply-To: <Pine.GSO.4.21.0211232133510.20022-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.44.0211231442190.660-100000@blessed>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Nov 2002, Geert Uytterhoeven wrote:

> On Fri, 22 Nov 2002, Josh Myer wrote:
> > I've got an EPIA board, with a trident CyberBlade chipset. Does anyone
> > have doco on this chipset? The random Xfree stuff available from VIA is
>
> Is this the Cyber9397? I have some PDF docs about that chip at home.
>
> Gr{oetje,eeting}s,
>
> 						Geert

Unfortunately, it's a CyberBlade i1, which looks to be distinct from that
chip in the driver source i have here.

lspci -vv:
01:00.0 VGA compatible controller: Trident Microsystems CyberBlade/i1 (rev
6a) (prog-if 00 [VGA])
        Subsystem: Trident Microsystems CyberBlade/i1

--
/jbm, but you can call me Josh. Really, you can!
 "What's a metaphor?" "For sheep to graze in"
7958 1C1C 306A CDF8 4468  3EDE 1F93 F49D 5FA1 49C4




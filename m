Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268016AbTBYQWi>; Tue, 25 Feb 2003 11:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268020AbTBYQWi>; Tue, 25 Feb 2003 11:22:38 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:22705 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S268016AbTBYQWh>;
	Tue, 25 Feb 2003 11:22:37 -0500
Date: Tue, 25 Feb 2003 17:28:54 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@infradead.org>
cc: Adrian Bunk <bunk@fs.tum.de>, Alan Cox <alan@redhat.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.62-ac1
In-Reply-To: <Pine.LNX.4.44.0302251625110.5086-100000@phoenix.infradead.org>
Message-ID: <Pine.GSO.4.21.0302251728330.15407-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2003, James Simmons wrote:
> > > Hm. Looks like pnmtologo didn't get compiled. In scripts/Makefile add 
> > > pnmtologo to host-progs   := 
> > > 
> > > That shoudl fix the problem.
> > 
> > No, you forgot to include scripts/pnmtologo in your latest fbdev.diff.gz.
> 
> I thought pnmtologo was a generated binary.

Sorry, I meant scripts/pnmtologo.c.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


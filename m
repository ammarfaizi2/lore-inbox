Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268057AbTBYQQA>; Tue, 25 Feb 2003 11:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268060AbTBYQQA>; Tue, 25 Feb 2003 11:16:00 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:31507 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S268057AbTBYQP7>; Tue, 25 Feb 2003 11:15:59 -0500
Date: Tue, 25 Feb 2003 16:26:04 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Adrian Bunk <bunk@fs.tum.de>, Alan Cox <alan@redhat.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.62-ac1
In-Reply-To: <Pine.GSO.4.21.0302231206070.28532-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.44.0302251625110.5086-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Hm. Looks like pnmtologo didn't get compiled. In scripts/Makefile add 
> > pnmtologo to host-progs   := 
> > 
> > That shoudl fix the problem.
> 
> No, you forgot to include scripts/pnmtologo in your latest fbdev.diff.gz.

I thought pnmtologo was a generated binary.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264920AbSK0XLH>; Wed, 27 Nov 2002 18:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264925AbSK0XLH>; Wed, 27 Nov 2002 18:11:07 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:30728 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264920AbSK0XLG>; Wed, 27 Nov 2002 18:11:06 -0500
Date: Wed, 27 Nov 2002 23:18:22 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: linux-fbdev-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: Fbdev 2.5.49 BK fixes.
In-Reply-To: <3DE50A1D.856A8706@aitel.hist.no>
Message-ID: <Pine.LNX.4.44.0211272254440.30951-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> No.  The machine froze solid. No oops, no sysrq.
> The reset button worked.

VESA fbdev did this to me. I have no trouble with neofb. Strange???
I will track it down tonight.

> > Hm. Are you using a PPC or ix86 box? I will test this tonight.
> i386.  Specifically, a pentium II, compiled for pentium II.

Hm. I have that same card and a similar machine.
 
> Perhaps. It didn't look like it ended at the bottom of the
> screen, but then it might have been panning at the wrong moment.

I have a MDA monitor and card. So I can setup mdacon and turn on 
debugging in fbcon and trace threw it. 
 
> > > 2.5.49 without this patch works.  I use devfs & preempt,
> > > the machine is UP and I use gcc-2.95.4 for compiling.
> 
> Helge Hafting
> 


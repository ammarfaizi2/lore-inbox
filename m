Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbUCCTPj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 14:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbUCCTPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 14:15:39 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:16142 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262548AbUCCTPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 14:15:36 -0500
Date: Wed, 3 Mar 2004 19:15:30 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Kars de Jong <jongk@linux-m68k.org>,
       Richard Zidlicky <rz@linux-m68k.org>,
       Russell King <rmk@arm.linux.org.uk>,
       Linux/m68k kernel mailing list 
	<linux-m68k@lists.linux-m68k.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: Usage of readb() and friends...
In-Reply-To: <1078271367.21573.212.camel@gaston>
Message-ID: <Pine.LNX.4.44.0403031914060.30666-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


No. I lost my SCSI driver. So I lost my main machine. I need a new driver 
but don't have the money to buy a drive right now. Maybe someone would be 
kind to donate me a Ultra Wide SCSI 2 drive.

On Wed, 3 Mar 2004, Benjamin Herrenschmidt wrote:

> >  the code with imageblit calls. The new fb_write 
> > code for some reson tho scrambles the console screen and then scrolls the 
> > screen below where I'm writing. I haven't figured out way yet.
> 
> BTW. Have had a chance to look into those memory corruption issues
> I told you about ? I've been rather busy lately...
> 
> Ben.
> 
> 
> 
> 


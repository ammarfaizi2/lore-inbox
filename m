Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbUKFSlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbUKFSlU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 13:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbUKFSlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 13:41:20 -0500
Received: from adsl-70-241-70-1.dsl.hstntx.swbell.net ([70.241.70.1]:13960
	"EHLO leamonde.no-ip.org") by vger.kernel.org with ESMTP
	id S261436AbUKFSlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 13:41:13 -0500
Date: Sat, 6 Nov 2004 12:41:12 -0600
From: "Camilo A. Reyes" <camilo@leamonde.no-ip.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Console 80x50 SVGA
Message-ID: <20041106184112.GC16891@leamonde.no-ip.org>
References: <20041105224206.GA16741@leamonde.no-ip.org> <20041106073901.GA783@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041106073901.GA783@alpha.home.local>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2004 at 08:39:01AM +0100, Willy Tarreau wrote:
> Hi,
> 
> On Fri, Nov 05, 2004 at 04:42:06PM -0600, Camilo A. Reyes wrote:
> > Just a question about displaying the console in 80x50 lines instead of
> > 80x30. I have enabled frame buffer but as of now its doing only 80x30.
> 
> You need to change the mode at boot (vga=XXX). I'm in 128x48 for example
> because my frame buffer is 1024x768 and my font is 8x16. You can also
> change your font size. 80x50 is doable with a 8x8 font in 640x400, but it
> is not really readable.
> 
> Cheers,
> Willy

If I may ask what vga number are you using to set it to 1024x768.
I believe I have tried it before with no success, but I'm willing
to try again.

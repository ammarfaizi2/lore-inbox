Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317592AbSHYVvA>; Sun, 25 Aug 2002 17:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317602AbSHYVvA>; Sun, 25 Aug 2002 17:51:00 -0400
Received: from host179.debill.org ([64.245.56.179]:60351 "EHLO mail.debill.org")
	by vger.kernel.org with ESMTP id <S317592AbSHYVu7>;
	Sun, 25 Aug 2002 17:50:59 -0400
Date: Sun, 25 Aug 2002 16:55:15 -0500
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel losing time
Message-ID: <20020825215515.GA2965@debill.org>
References: <20020825105500.GE11740@paradise.net.nz> <Pine.LNX.4.44.0208250459500.3234-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208250459500.3234-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.3.28i
From: erik@debill.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2002 at 05:01:19AM -0600, Thunder from the hill wrote:
> Hi,
> 
> On Sun, 25 Aug 2002, Volker Kuhlmann wrote:
> > I am stuck with a kernel problem someone can hopefully shed some light
> > on. It's also a bug report.
> 
> And it's already known. It's VIA chipset which obviously can't read the 
> clock ;-) Chipset kicking wrong interrupts, timer can't help it.
> 

Would this explain my computer losing 2-3 minutes of time while
ripping a cd?  Normally it's dead on (w/ ntpd running to guarantee
that) but while ripping or burning it loses so badly ntpd can't keep
up.

Gig athlon/VIA chipset w/ burner on a Promise PCI card.


Erik

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317862AbSHZDA4>; Sun, 25 Aug 2002 23:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317864AbSHZDA4>; Sun, 25 Aug 2002 23:00:56 -0400
Received: from host179.debill.org ([64.245.56.179]:61375 "EHLO mail.debill.org")
	by vger.kernel.org with ESMTP id <S317862AbSHZDA4>;
	Sun, 25 Aug 2002 23:00:56 -0400
Date: Sun, 25 Aug 2002 22:05:12 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel losing time
Message-ID: <20020826030512.GA3264@debill.org>
References: <20020825105500.GE11740@paradise.net.nz> <Pine.LNX.4.44.0208250459500.3234-100000@hawkeye.luckynet.adm> <20020825215515.GA2965@debill.org> <1030320314.16766.25.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1030320314.16766.25.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
From: erik@debill.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 01:05:14AM +0100, Alan Cox wrote:
> On Sun, 2002-08-25 at 22:55, erik@debill.org wrote:
> > Would this explain my computer losing 2-3 minutes of time while
> > ripping a cd?  Normally it's dead on (w/ ntpd running to guarantee
> > that) but while ripping or burning it loses so badly ntpd can't keep
> > up.
> 
> Could be - does hdparm -u1 on that device fix it ?

nope.  I still lost a minute or so ripping a single disc.  This is
using 2.4.19-rc3, though I've not seen a kernel where it /didn't/
happen.


Erik



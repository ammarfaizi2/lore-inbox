Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316600AbSEUVLK>; Tue, 21 May 2002 17:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316603AbSEUVLJ>; Tue, 21 May 2002 17:11:09 -0400
Received: from ool-182d4c76.dyn.optonline.net ([24.45.76.118]:52228 "EHLO
	physics.dyndns.org") by vger.kernel.org with ESMTP
	id <S316600AbSEUVLI>; Tue, 21 May 2002 17:11:08 -0400
Date: Tue, 21 May 2002 18:10:16 -0400 (EDT)
From: "Nicholas L. D'Imperio" <dimperio@physics.dyndns.org>
To: Ion Badulescu <ionut@cs.columbia.edu>
cc: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Asus a7m266d stability issues
In-Reply-To: <200205212044.g4LKi1i21931@buggy.badula.org>
Message-ID: <Pine.LNX.4.33.0205211807030.1087-100000@physics.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2002, Ion Badulescu wrote:

> On Tue, 21 May 2002 16:07:24 -0400 (EDT), Nicholas L. D'Imperio <dimperio@physics.dyndns.org> wrote:
> 
> >> > I'm getting kernel panics using the A7m266d smp motherboard and kernel 
> >> > 2.4.18 as soon as the system is put under load.
> > 
> > I have 1800+MP processors and my PSU is 400W.  Of course I also have the 
> > little four prong connector plugged in as well.
> 
> This points very strongly towards an overheating problem. The 1800+ and 
> higher CPU's run very hot. Any imperfection in the cooling setup, be 
> it lack of thermal paste, undersized heatsink/fan combination, 
> improperly seated heatsink, and even insufficient airflow around the
> CPU's and inside the chassis, can and will cause crashes under load.
> 
> I had this exact problem a few weeks ago with a dual Athlon 1U setup. It
> turned out that the aluminum heatsinks I had previously used for the
> 1.2GHz Athlons weren't good enough for the 1900+, and also that the
> chassis fans were circulating enough air. Switching to copper heatsinks
> got rid of 95% of the crashes, and adding a chassis fan got rid of the
> remaining 5%.
> 
> Ion
> 
> 

Overheating is certainly a concern but is not the problem here I think.  

1 processor is rock solid.

I also switched it with a dual TigerMP board and that runs fine.


Nick


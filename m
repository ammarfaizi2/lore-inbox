Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314665AbSD1CVK>; Sat, 27 Apr 2002 22:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314666AbSD1CVK>; Sat, 27 Apr 2002 22:21:10 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:1041 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S314665AbSD1CVI>; Sat, 27 Apr 2002 22:21:08 -0400
Date: Sat, 27 Apr 2002 19:18:30 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while
 reading damadged files
In-Reply-To: <20020425205035.A160@toy.ucw.cz>
Message-ID: <Pine.LNX.4.10.10204271910510.15403-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well I really do not have the time to follow the changes, but when I fix
it in 2.4, please copy a and credit would be nice but not expected.  Also
it made resulted in a more complex mess to address.


Regards,

Andre Hedrick
LAD Storage Consulting Group


On Thu, 25 Apr 2002, Pavel Machek wrote:

> Hi!
> 
> > Basically it is a global design flaw from the beginning, and since I have
> > only 2.4 to address it is a real nasty!  Short version, each subdriver
> 
> Well, noone prevents you from submitting 2.5 patches to Martin.... Actually,
> his cleanups maybe made that job easier.
> 
> 								Pavel
> -- 
> Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
> details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.
> 


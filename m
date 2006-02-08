Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030586AbWBHQee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030586AbWBHQee (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 11:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030584AbWBHQee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 11:34:34 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:54152 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1030587AbWBHQed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 11:34:33 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Wed, 08 Feb 2006 17:32:38 +0100
To: schilling@fokus.fraunhofer.de, jim@why.dont.jablowme.net
Cc: peter.read@gmail.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43EA1D26.nail40E11SL53@burner>
References: <200602021717.08100.luke@dashjr.org>
 <Pine.LNX.4.61.0602031502000.7991@yvahk01.tjqt.qr>
 <200602031724.55729.luke@dashjr.org> <43E7545E.nail7GN11WAQ9@burner>
 <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de>
 <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner>
 <20060207183712.GC5341@voodoo> <43E9F1CD.nail2BR11FL52@burner>
 <20060208162828.GA17534@voodoo>
In-Reply-To: <20060208162828.GA17534@voodoo>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jim Crilly" <jim@why.dont.jablowme.net> wrote:

> On 02/08/06 02:27:41PM +0100, Joerg Schilling wrote:
> > "Jim Crilly" <jim@why.dont.jablowme.net> wrote:
> > 
> > > All you've explained is that using SCSI ID for device names is the way
> > > you want cdrecord to work, not why it's infinitely better than using real
> > > device names like every other userland program on every OS in existance.
> > 
> > I did many times, but people don't seem to listen.
>
> But you've never answered the question as to why every other userland
> program on every OS uses device names when cdrecord insists on using SCSI
> IDs. Do you really think mount, fsck, tar, etc are broken because they let
> the user use device names that they're accustomed to like /dev/c0t0d0s0? If
> so, I look forward to the day that you try to patch OpenSolaris' userland
> to work like cdrecord. 

You just verify that you don't listen...

I did answer this many times and I will not repeat it another time.

Note that you are of course wrong with your statement on other CD/DVD writing 
software.

What you like to see does not work at all on MS-WIN.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily

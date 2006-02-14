Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030491AbWBNSnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030491AbWBNSnh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 13:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbWBNSnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 13:43:37 -0500
Received: from atpro.com ([12.161.0.3]:7434 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S1030491AbWBNSng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 13:43:36 -0500
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Tue, 14 Feb 2006 13:43:25 -0500
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: dhazelton@enter.net, peter.read@gmail.com, mj@ucw.cz,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jerome.lacoste@gmail.com, jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060214184324.GC4749@voodoo>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	dhazelton@enter.net, peter.read@gmail.com, mj@ucw.cz,
	matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
	jerome.lacoste@gmail.com, jengelh@linux01.gwdg.de
References: <20060208162828.GA17534@voodoo> <200602092241.29294.dhazelton@enter.net> <43F08D45.nailKUSE1SA4H@burner> <200602131801.47050.dhazelton@enter.net> <43F1DD0A.nailMWZ718HUV@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43F1DD0A.nailMWZ718HUV@burner>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/14/06 02:37:14PM +0100, Joerg Schilling wrote:
> "D. Hazelton" <dhazelton@enter.net> wrote:
> 
> > > -	does not need more time to integrate than I would need to
> > > 	write this from scratch
> > >
> > > Unfortunately, many people who send patches to me do not follow
> > > these simple rules.
> >
> > Okay - show me your standards document and I'll get to work on a patch to do 
> > what I earlier proposed. It won't be "adding new functionality" but it will 
> > be making the interface a tiny bit simpler for the novice user.
> 
> ?????
> 
> 1)	RTFM
> 2)	ftp://ftp.berlios.de/pub/cdrecord/PORTING
> 3)	http://cdrecord.berlios.de/old/private/port.ps
> 4)	http://cvs.opensolaris.org/source/xref/on/usr/src/tools/scripts/cstyle.pl
> 
> 
> If you do not follow the spirit of the interface design or of you break
> things on other OS, your patch will not be accepted.
> 
> Jörg

You're allowed to yell RTFM to him, but when you were pointed to the HAL
documentation you cried that you didn't want to spend time reading it? How
does that work?

Jim.

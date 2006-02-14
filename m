Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422851AbWBNWF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422851AbWBNWF6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 17:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422853AbWBNWF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 17:05:58 -0500
Received: from smtp.enter.net ([216.193.128.24]:47890 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1422851AbWBNWF5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 17:05:57 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Tue, 14 Feb 2006 17:15:09 -0500
User-Agent: KMail/1.8.1
Cc: peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jerome.lacoste@gmail.com, jengelh@linux01.gwdg.de
References: <20060208162828.GA17534@voodoo> <200602131801.47050.dhazelton@enter.net> <43F1DD0A.nailMWZ718HUV@burner>
In-Reply-To: <43F1DD0A.nailMWZ718HUV@burner>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602141715.09828.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 February 2006 08:37, Joerg Schilling wrote:
> "D. Hazelton" <dhazelton@enter.net> wrote:
> > > -	does not need more time to integrate than I would need to
> > > 	write this from scratch
> > >
> > > Unfortunately, many people who send patches to me do not follow
> > > these simple rules.
> >
> > Okay - show me your standards document and I'll get to work on a patch to
> > do what I earlier proposed. It won't be "adding new functionality" but it
> > will be making the interface a tiny bit simpler for the novice user.
>
> ?????
>
> 1)	RTFM
> 2)	ftp://ftp.berlios.de/pub/cdrecord/PORTING
> 3)	http://cdrecord.berlios.de/old/private/port.ps
> 4)	http://cvs.opensolaris.org/source/xref/on/usr/src/tools/scripts/cstyle.p
>l
>
>
> If you do not follow the spirit of the interface design or of you break
> things on other OS, your patch will not be accepted.
>
> Jörg

I shall and thank you. Given current constraints on my time I should have the 
patch I mentioned available in no more than two weeks.

If my patch breaks something on another OS, then please inform me so that I 
can modify the code and send you a fixed patch. After all, as I've said 
before, I don't have the access to the resources you do for testing.

DRH

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316988AbSEWTNG>; Thu, 23 May 2002 15:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316990AbSEWTNF>; Thu, 23 May 2002 15:13:05 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:22283
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S316988AbSEWTNE>; Thu, 23 May 2002 15:13:04 -0400
Date: Thu, 23 May 2002 12:11:25 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Tomas Szepe <szepe@pinerecords.com>,
        "Gryaznova E." <grev@namesys.botik.ru>, linux-kernel@vger.kernel.org
Subject: Re: IDE problem: linux-2.5.17
In-Reply-To: <3CED2B9D.4080402@evision-ventures.com>
Message-ID: <Pine.LNX.4.10.10205231204500.22581-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well if people are doing embedded in close quarters and they can use the
knowledge, they need to have it.  The drive is/was designed to deal with
this issue in several ways.

Testing the for the decay from POST for DEVICE side detection of any
capable cable.  Next if the HOST also supports detection and it senses its
own cable capacitance is acceptable, then it will work.

You need to be able to support conclusions of how and why, because people
will see this in the real world and wonder why.

Cheers,


On Thu, 23 May 2002, Martin Dalecki wrote:

> Uz.ytkownik Andre Hedrick napisa?:
> > Not true at all.
> > 
> > Many of the OEM's use 40c's to do 66 and 100, just they have to be very
> > high quality and about 6" in length.
> > 
> 
> Please don't confuse people the standard is clear.
> The OEM's are just cheap becous they can controll what they
> put in to the box and how they layout the cables inside
> the box. If someone asks. The 80 lines are half the same
> contacts as before and half signal shilding. So indeed
> 40 wire cables can turn out to work, but thats subjec to
> "quality" assurance on behalf of the OEM's.
> 

Andre Hedrick
LAD Storage Consulting Group


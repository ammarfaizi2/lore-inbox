Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268219AbTBNGV3>; Fri, 14 Feb 2003 01:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268220AbTBNGV3>; Fri, 14 Feb 2003 01:21:29 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:5392 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S268219AbTBNGV0> convert rfc822-to-8bit; Fri, 14 Feb 2003 01:21:26 -0500
Date: Thu, 13 Feb 2003 22:27:58 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Matthias Schniedermeyer <ms@citd.de>
cc: =?unknown-8bit?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Promise SATA chips
In-Reply-To: <20030213205127.GA11546@citd.de>
Message-ID: <Pine.LNX.4.10.10302132227031.6903-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This one is the HPT374 with Marvell bridge chips slapped on it.
It is natively supported with the PATA driver.

Cheers,

On Thu, 13 Feb 2003, Matthias Schniedermeyer wrote:

> On Thu, Feb 13, 2003 at 02:04:50AM -0800, Andre Hedrick wrote:
> > On 13 Feb 2003, Måns Rullgård wrote:
> > 
> > > > Use Silicon Image products.
> > > 
> > > I can't get them.
> > 
> > Hogwash, they dominate the market space and are on all the Intel
> > Mainboards that are 845e and above.
> 
> Btw. I've looked and the "HighPoint RocketRAID 1540" (4 Channel
> Serial-ATA) looks "nice".
> 
> Is/Should this controller be supported by the "siimage"-driver?
> 
> 
> 
> 
> Bis denn
> 
> -- 
> Real Programmers consider "what you see is what you get" to be just as 
> bad a concept in Text Editors as it is in women. No, the Real Programmer
> wants a "you asked for it, you got it" text editor -- complicated, 
> cryptic, powerful, unforgiving, dangerous.
> 

Andre Hedrick
LAD Storage Consulting Group


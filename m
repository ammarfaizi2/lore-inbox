Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318299AbSHPLT1>; Fri, 16 Aug 2002 07:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318304AbSHPLT1>; Fri, 16 Aug 2002 07:19:27 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:32272
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318299AbSHPLT0>; Fri, 16 Aug 2002 07:19:26 -0400
Date: Fri, 16 Aug 2002 04:13:57 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: Part 2: Re: 2.5.31 boot failure on pdc20267
In-Reply-To: <22B231216B8@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.10.10208160411360.12468-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2002, Petr Vandrovec wrote:

> On 16 Aug 02 at 3:23, Andre Hedrick wrote:
> > Try reading the entire document first before commenting and showing why
> > people should not believe you.
> > 
> > The author went through great lengths to explain and capture what
> > SFF-8038i defined.  The object is to show the difference.
> > 
> > Now carefully look and see that BAR4 in d1510 is not the same as 
> > BAR 4 for SFF-8038i.
> 
> Chapter 5 describes IDE class devices, PCI class 0101. If this chapter 
> 
> Chapter 3, ATA Host Adapters, and also document name, ATA Host Adapters

ATA class devices, PCI class 0105.

This what you missed, this what we are debating.  :-/

Cheers,


Andre Hedrick
LAD Storage Consulting Group


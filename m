Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314705AbSEHS6a>; Wed, 8 May 2002 14:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314707AbSEHS63>; Wed, 8 May 2002 14:58:29 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:14350
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S314705AbSEHS63>; Wed, 8 May 2002 14:58:29 -0400
Date: Wed, 8 May 2002 11:55:47 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Anton Altaparmakov <aia21@cantab.net>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bjorn Wesen <bjorn.wesen@axis.com>, Paul Mackerras <paulus@samba.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE 58
In-Reply-To: <5.1.0.14.2.20020508192557.0409b1f0@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.10.10205081154370.30697-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 May 2002, Anton Altaparmakov wrote:

> </me ignorant>Um, what about the IDE PCI cards which have 4 channels on 
> them? Like these two:
> 
> Adaptec 2400 4Ch IDE Raid Controller
> RocketRaid 404 4Ch ATA133 Raid Host Adaptor

It is not an issue since they broadcast as single channel pairs per host.
Martin is winning the argument hands down.

Andre Hedrick
LAD Storage Consulting Group


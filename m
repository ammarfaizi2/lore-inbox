Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318302AbSHPMM5>; Fri, 16 Aug 2002 08:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318338AbSHPMM5>; Fri, 16 Aug 2002 08:12:57 -0400
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:6826 "EHLO nick")
	by vger.kernel.org with ESMTP id <S318302AbSHPMM4>;
	Fri, 16 Aug 2002 08:12:56 -0400
Date: Fri, 16 Aug 2002 13:17:35 +0100 (BST)
From: Matt Bernstein <mb/lkml@dcs.qmul.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: GA-7DX+ crashes
In-Reply-To: <1029328539.26226.19.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208161313490.10843-100000@r2-pc.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Auth-User: mb
X-uvscan-result: clean (17fg28-0003c8-00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 14 Alan Cox wrote:
>On Wed, 2002-08-14 at 13:12, Matt Bernstein wrote:
>> We're very much at a loss as to why the 60 new PCs we've bought largely
>> don't run Linux (various 2.4 kernels including 2.4.19, limbo1-BOOT) for
>> very long without crashing. One of them seems to work OK; its /proc/pci is 
>> identical, but the batch number on the southbridge seems one lower--is 
>> this dodgy VIA hardware again? We'll be trying a different IDE controller 
>> next, but 60 of those ain't cheap..
>
>My immediate assumption would be a batch of bad hardware or faulty bios

The former seems to be the case, after talking to Gigbayte. (We got
Windows to crash much more spectacularly after stressing it a little
harder--that gets the company who sold them to us to come over personally
:)

Thanks very much--hopefully our dual-boot lab will continue to exist for
the next academic year!

Matt


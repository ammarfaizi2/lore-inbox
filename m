Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267373AbRGYVMb>; Wed, 25 Jul 2001 17:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267338AbRGYVMU>; Wed, 25 Jul 2001 17:12:20 -0400
Received: from as2-1-8.va.g.bonet.se ([194.236.117.122]:50180 "EHLO
	boris.prodako.se") by vger.kernel.org with ESMTP id <S267373AbRGYVME>;
	Wed, 25 Jul 2001 17:12:04 -0400
Date: Wed, 25 Jul 2001 23:11:48 +0200 (CEST)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: <tori@boris.prodako.se>
To: "TO. Wilderman Ceren" <wceren@cioh.org.co>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problems with dmfe.o in 2.4.7 (fwd) 
In-Reply-To: <Pine.LNX.4.33L2.0107251504040.9437-100000@sigma.cioh.org.co>
Message-ID: <Pine.LNX.4.33.0107252255210.14911-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wed, 25 Jul 2001, TO. Wilderman Ceren wrote:

> Ok., I'm trying the eth1 (Davicom 9102) with tulip module shared with eth0
> (Digital).

Did you succeed to load the dmfe.o module?  It should work just fine.  The
tulip driver works fine for the Davicom 9102 chip for most people, but not
all for some reason.

The dmfe driver does support more Davicom chips (and bugs) than the tulip
driver right now. Please let me know if you experince further problems
with the dmfe driver.

/Tobias


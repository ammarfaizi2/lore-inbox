Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267525AbRGRTAP>; Wed, 18 Jul 2001 15:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267914AbRGRTAG>; Wed, 18 Jul 2001 15:00:06 -0400
Received: from dsl081-067-047.sfo1.dsl.speakeasy.net ([64.81.67.47]:51464 "EHLO
	disorder.primate.net") by vger.kernel.org with ESMTP
	id <S267525AbRGRS7s>; Wed, 18 Jul 2001 14:59:48 -0400
Date: Wed, 18 Jul 2001 12:00:32 -0700 (PDT)
From: Aaron T Porter <atporter@primate.net>
To: NewRootToy <diablo@biglinux.tccw.wku.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Old Ne2000 Card with Starlan Port (I think)
In-Reply-To: <Pine.LNX.4.33.0107181340190.12277-100000@biglinux.tccw.wku.edu>
Message-ID: <Pine.LNX.4.10.10107181159370.24888-100000@disorder.primate.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2001, NewRootToy wrote:

> I am trying to use linux to talk to a cabletron managed switch.
> 
> I have an old NE2000 card made by national semiconductor, which has what I
> beleive to be called a starlan port (15 pin female connector) as well as
> the standard twisted pair connector.  What do I need to tell linux to make
> it talk through that Starfire(?) port?

	I think you've got yourself an AUI port. It's ethernet, nothing
special. You can buy (probably) an AUI to UTP (10BaseT) adapter, I've got one
on my old Sparc.


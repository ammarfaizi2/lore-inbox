Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292603AbSCDRxJ>; Mon, 4 Mar 2002 12:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292594AbSCDRvO>; Mon, 4 Mar 2002 12:51:14 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:32162 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S292612AbSCDRud>; Mon, 4 Mar 2002 12:50:33 -0500
Date: Mon, 4 Mar 2002 11:05:14 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Harald van Pee <pee@iskp.uni-bonn.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3Ware Hard Bus Hang 2.4.18 > 220 MB/S
Message-ID: <20020304110514.B31724@vger.timpanogas.org>
In-Reply-To: <200203041706.g24H6Kv25543@klee.iskp.uni-bonn.de> <20020304103847.A31515@vger.timpanogas.org> <200203041736.g24HaYv25738@klee.iskp.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200203041736.g24HaYv25738@klee.iskp.uni-bonn.de>; from pee@iskp.uni-bonn.de on Mon, Mar 04, 2002 at 06:36:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


#Ware is fixing this problem, so I expect a fix soon.  You won't
see the problem unless you are using multiple cards, and running 
them at very high data rates.

Jeff


On Mon, Mar 04, 2002 at 06:36:33PM +0100, Harald van Pee wrote:
> On Monday 04 March 2002 18:38, Jeff V. Merkey wrote:
> > Problem seems specific to the SuperMicro motherboard + 3Ware.
> >
> Because this is the same configuration which I will buy
> (the very similar means I need only three but 4 3ware cards, and I have the 
> option to buy a netgear card)
> this doesn't help me.
> 
> Such systems are used at DESY in Hamburg 
> with no problems 
> (www.desy.de/unix/linux/delfi/delfi.html)
> and therefore I want to know if the rate, firmware or the kernel or driver 
> version makes the difference.
> 
> Regards
> Harald

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271674AbRH0JOJ>; Mon, 27 Aug 2001 05:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271678AbRH0JN7>; Mon, 27 Aug 2001 05:13:59 -0400
Received: from www.heureka.co.at ([195.64.11.111]:61705 "EHLO
	www.heureka.co.at") by vger.kernel.org with ESMTP
	id <S271675AbRH0JNt>; Mon, 27 Aug 2001 05:13:49 -0400
Date: Mon, 27 Aug 2001 11:13:39 +0200
From: David Schmitt <david@heureka.co.at>
To: linux-kernel@vger.kernel.org
Subject: Re: ISSUE: DFE530-TX REV-A3-1 times out on transmit
Message-ID: <20010827111339.A10126@www.heureka.co.at>
In-Reply-To: <20010824162425.D27794@www.heureka.co.at> <Pine.LNX.4.10.10108251801480.13314-100000@ada.teststation.com> <20010827102740.A9557@www.heureka.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010827102740.A9557@www.heureka.co.at>
User-Agent: Mutt/1.3.20i
Organization: Heureka - Der EDV-Dienstleister
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

sorry for replying on my on message.

On Mon, Aug 27, 2001 at 10:27:40AM +0200, David Schmitt wrote:
> On Sat, Aug 25, 2001 at 07:05:26PM +0200, Urban Widmark wrote:
> > On Fri, 24 Aug 2001, David Schmitt wrote:
> > > 	Reloading the module doesn't help either. Only a reboot
> > > 	reenables network connectivity.
> > 
> > There is a patch in the 2.4.8-acX kernels that fixes a problem with
> > reseting the card when it is first used. I can't say that I know that it
> > fixes anything you are seeing, but it could be worth trying.
> 
> Ok, I will try that too and report back.

Nope. Using the patched via-rhine.c from 2.4.8-ac12 didn't help.


Regards, David Schmitt
-- 
Sponsored by heureKA, Austria (http://www.heureka.co.at)

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268587AbRG3NPK>; Mon, 30 Jul 2001 09:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268588AbRG3NOt>; Mon, 30 Jul 2001 09:14:49 -0400
Received: from mta01-svc.ntlworld.com ([62.253.162.41]:47758 "EHLO
	mta01-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S268587AbRG3NOm>; Mon, 30 Jul 2001 09:14:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Gav <gavbaker@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: Re: VIA KT133A / athlon / MMX
Date: Mon, 30 Jul 2001 13:59:33 +0000
X-Mailer: KMail [version 1.2]
In-Reply-To: <E15QEP3-0006TF-00@the-village.bc.nu> <01072904032900.04737@box.penguin.power> <3B65099E.8004F9E5@scali.no>
In-Reply-To: <3B65099E.8004F9E5@scali.no>
MIME-Version: 1.0
Message-Id: <01073013584200.01389@box.penguin.power>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Monday 30 July 2001 07:15, Steffen Persvold wrote:

> > While DRAM Prefetch is supposed to be an option to increase performance,
> > my sound is totally unusable without this set. I've heard numerous people
> > explain the same problem and it would be interesting to find out if this
> > cures their sound troubles too. If this is the case, is this something
> > that belongs in quirks, or is it too hardware specific? and would
> > enabling this by default hurt anything anyway? Or is this just masking
> > the underlaying problem ?
>
> Hmm, I think "DRAM Prefetch" is the one you _don't_ want to turn on,
> because (and correct me if i'm wrong) it's causing all the problems with
> the IDE controller (data trashing).

Obviously I can only comment on my own hardware but the machine has been used 
constantly since Thu Jul 12, its now Jul 30 and I havent had a single IDE 
related problem. 

As a hobby, i use the machine for DigitalVideo, and regularly grab 20-30GB 
from my capture card, then process it, which means the IDE bus gets a lot of 
use and seems to be an ideal situation for the data trashing problems to rear 
their ugly heads (no pun intended) but, as i said, I haven't seen any here.

DRAM Prefetch makes my sound usuable, as the VIA fixups for the SB cards do 
not work here, and for (at least) two other people who i have had email 
correspondancy with.

-- Regards, Gavin Baker


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268537AbRHGPQt>; Tue, 7 Aug 2001 11:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268427AbRHGPQj>; Tue, 7 Aug 2001 11:16:39 -0400
Received: from mueller.uncooperative.org ([216.254.102.19]:45583 "EHLO
	mueller.datastacks.com") by vger.kernel.org with ESMTP
	id <S268342AbRHGPQZ>; Tue, 7 Aug 2001 11:16:25 -0400
Date: Tue, 7 Aug 2001 11:16:35 -0400
From: Crutcher Dunnavant <crutcher@datastacks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
Message-ID: <20010807111635.A4364@mueller.datastacks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> <E15U7gC-0002xe-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15U7gC-0002xe-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Aug 07, 2001 at 03:17:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

++ 07/08/01 15:17 +0100 - Alan Cox:
> > A relatively cheap way might be a custom pci
> > card with a self-destruct RAM bank for
> > storing the decryption keys.  Opening the 
> > safe cause the card to zero the RAM.  
> 
> IBM sell crypto PCI cards with anti tamper environments, they have
> development drivers on their oss site too

Ohh. Some college buddies and I were considering the difficulty involved from
making a pci card with an onboard giger counter and radiatian source (say, from
a smoke detector) wrapped up in some lead.

Sure, there are simpler ways to build chaotic circuits, but a radioactive
peripheral is cool!

-- 
Crutcher        <crutcher@datastacks.com>
GCS d--- s+:>+:- a-- C++++$ UL++++$ L+++$>++++ !E PS+++ PE Y+ PGP+>++++
    R-(+++) !tv(+++) b+(++++) G+ e>++++ h+>++ r* y+>*$

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267487AbUG2WWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267487AbUG2WWQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 18:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267486AbUG2WWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 18:22:16 -0400
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:63441 "EHLO
	clueserver.org") by vger.kernel.org with ESMTP id S265697AbUG2WWO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 18:22:14 -0400
Date: Thu, 29 Jul 2004 14:28:13 -0700 (PDT)
From: alan <alan@clueserver.org>
X-X-Sender: alan@www.fnordora.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rogier Wolff <Rogier@wolff.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OK, anybody have any hints and tips to get an MFM drive working
 again?
In-Reply-To: <1091135075.1453.5.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0407291427050.30292-100000@www.fnordora.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2004, Alan Cox wrote:

> On Iau, 2004-07-29 at 21:14, Rogier Wolff wrote:
> > I THINK we have a couple of those cards that don't have any 
> > interrupts. Would Linux be able to work with those?
> 
> The old hd driver should support this in 2.4 and 2.6. Its fair to
> say that neither hd.c nor xd.c get much testing nowdays. One of the
> biggest problems tends to be finding a machine you can use the old MFM
> cards in because any motherboard disk controller will clash.

Not to mention that many MFM boards were not very static resistant and 
tended to die if handled without proper grounding.  (I lost one that way.)



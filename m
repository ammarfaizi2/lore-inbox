Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268999AbUIQQam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268999AbUIQQam (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 12:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269028AbUIQQ2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 12:28:03 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:52725 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269008AbUIQQYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 12:24:25 -0400
Message-ID: <470b639704091709191a5fe1d9@mail.gmail.com>
Date: Fri, 17 Sep 2004 09:19:58 -0700
From: Tony Lee <tony.p.lee@gmail.com>
Reply-To: Tony Lee <tony.p.lee@gmail.com>
To: Andre Tomt <andre@tomt.net>
Subject: Re: PCI coprocessors
Cc: Tonnerre <tonnerre@thundrix.ch>, Jeff Garzik <jgarzik@pobox.com>,
       Andre Bonin <kernel@bonin.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <414AB973.5070408@tomt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41483BD3.4030405@bonin.ca> <41486755.3070207@pobox.com>
	 <20040915223906.GA26458@thundrix.ch> <414AB973.5070408@tomt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2004 12:16:19 +0200, Andre Tomt <andre@tomt.net> wrote:
> Tonnerre wrote:
> > Salut,
> >
> > On Wed, Sep 15, 2004 at 12:01:25PM -0400, Jeff Garzik wrote:
> >
> >>I have long dreamed of being able to add a PCI card to my x86 system, a
> >>PCI card containing a processor (of any type), RAM, and an ethernet
> >>interface.  I would use this for routing, or iSCSI, or network offload...
> >
> >
> > Such as  the i386 co-computer  card for older Macintosh  computers? (I
> > can't remember what it was called.)
> 
> I've recently seen several ia32 PCI boards, with network, cpu, ram, etc.
> that works in modern PC's. Can't recall any names just now though. Not
> sure if they had any communication with the host over PCI either.


If you can get access to SDK for Broadcom 5704 (570x?) , you have GIGE nic
card with 2 133MHz MIPS CPU, one for TX, onr for RX.

Most of the NIC cards with BCM chip should be < $50.

Maybe enough of us bugging Broadcom, they will open up the SDK.

-- 
-Tony
Having a lot of fun with Xilinx Virtex Pro II reconfigurable HW + ppc + Linux

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262854AbTHURdm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 13:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbTHURdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 13:33:33 -0400
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:18328 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id S262854AbTHURdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 13:33:04 -0400
Date: Thu, 21 Aug 2003 13:32:33 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Bas Mevissen <ml@basmevissen.nl>
cc: Anders Karlsson <anders@trudheim.com>,
       Christian Axelsson <smiler@lanil.mine.nu>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Current status of Intel PRO/Wireless 2100
In-Reply-To: <3F421B6C.2050300@basmevissen.nl>
Message-ID: <Pine.LNX.4.56.0308211327220.6793@filesrv1.baby-dragons.com>
References: <3F3CA3A0.5030905@lanil.mine.nu> <1060942697.2296.83.camel@tor.trudheim.com>
 <3F421B6C.2050300@basmevissen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello Bas ,  Do you (or anyone else) know which of the 'PCI' based
	cards are use the 'mini-pci' cards on a bridge card ?

	I'd really like more of a selection to choose from than just
	Netgear .  The Netgear card you spoke of below religously doesn't
	mention Linux in it's support sections .  But ,  (hopefully) it
	appears that you are using under linux , correct ?  Tia ,  JimL

On Tue, 19 Aug 2003, Bas Mevissen wrote:
> Anders Karlsson wrote:
> > On Fri, 2003-08-15 at 10:10, Christian Axelsson wrote:
>   (mini-PCI WLAN cards in notebooks)
> > For the time being those mini-PCI cards is dead weight in the laptop I
> > am afraid. I hope that either Intel suddenly sees sense (snowflake in
> > hell analogy coming on) or some bright spark reverse engineers the card
> > and writes an alpha driver that surpasses the functionality of the Intel
> > beta drivers they keep under lock and key internally.
> > I'll probably locate some Prism CardBus card in the meantime to use.
> My dead weight was called Dell TrueMobile 1300 (with BroadCom chipset).
> What I did is buying a NetGear WG311 PCI card (802.11b/g). It contains a
> mini-pci card in a slot unders a metal cover and some small stuff on the
> PCI-shape PCB.
> The cover is easy to remove (only 3 pins) and the antenna is not
> soldered, but connected with the same connector as in my notebook. I
> could only connect 1 (main) antenna, but the PCI card has only one
> antenna too. So you only loose antenna diversity.
> The NetGear contains an Atheros chipset. There is some open source stuff
> available (URL forgotten) and a driver (mafwifi) with a binary-only
> hardware abstraction. Not really what you want, but at least a start. A
> combination of both may lead to a more desirable result. But for me it
> is fine to use. Only I can not issue bug reports when the driver has
> been loaded since the last boot.
> BTW. I have a PCI card with Broadcom chipset for sale now :-)
-- 
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263288AbTHWRAB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 13:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbTHWQ7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 12:59:11 -0400
Received: from filesrv1.system-techniques.com ([199.33.245.55]:29850 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id S263230AbTHWPoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 11:44:15 -0400
Date: Sat, 23 Aug 2003 11:44:10 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Bas Mevissen <ml@basmevissen.nl>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Current status of Intel PRO/Wireless 2100
In-Reply-To: <3F45E651.8000408@basmevissen.nl>
Message-ID: <Pine.LNX.4.56.0308221324260.13437@filesrv1.baby-dragons.com>
References: <3F3CA3A0.5030905@lanil.mine.nu> <1060942697.2296.83.camel@tor.trudheim.com>
 <3F421B6C.2050300@basmevissen.nl> <Pine.LNX.4.56.0308211327220.6793@filesrv1.baby-dragons.com>
 <3F45E651.8000408@basmevissen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello Bas ,

On Fri, 22 Aug 2003, Bas Mevissen wrote:
> Mr. James W. Laferriere wrote:
> > 	Hello Bas ,  Do you (or anyone else) know which of the 'PCI' based
> > 	cards are use the 'mini-pci' cards on a bridge card ?
> Probably all PCI-cards that have a huge metal casing. PCI WLAN cards are
> not so common (desktop and wireless is a bit silly :-))and hence the
> development costs for a "real" PCI WLAN card might be too high compared
> to the extra cost of using a Mini-PCI and a bridge. Actually, "bridge"
> is too much honour for the remaining card. Slot converter is more
> appropriate.
	There are also the pci-[cardbus|pcmcia] devices .  And in most of
	the usual closeup's you get of those things the picture is so
	smeared that there is very little way to tell the differances
	from looking at those pictures .  I did find Jean Tourrilhes site
	& documents on wireless for linux & am now using the information
	there to try to find 802.11g mini-pci versions that are supported
	by linux .

> > 	I'd really like more of a selection to choose from than just
> > 	Netgear .  The Netgear card you spoke of below religously doesn't
> > 	mention Linux in it's support sections .  But ,  (hopefully) it
> > 	appears that you are using under linux , correct ?  Tia ,  JimL
> We all like that. Actually, I wanted to have an 802.11a/b/g from a
> supplier that has real open source drivers. But it was all I could get
> on a short term.
> I use it with Linux. Actually, I did not more than a few tests. But I
> know it works and I verified it with the XP install that came with the
> notebook. I just had to install the PCI-card drivers there.
	Thank you for the confirmation .  If I should decide to pick up
	the netgear card I'll report back with success &/or horror
	reports .

> (general remark) Note that this kind of use of mini-pci modules is all
> on your own risk and responsibility. Maybe I better had not told this on
> LKML. But now that has happened, I advise people to think twice before
> doing it and ask me for details in private if they feel uncertain about it.
	I fully understand ,  It is not supported by the laptop
	manufacturers & if it breaks you tell me I get to keep all the
	pieces ;-) .  Tnx Again ,  JimL
-- 
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

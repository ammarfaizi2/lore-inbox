Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbTHVJoq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 05:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbTHVJoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 05:44:46 -0400
Received: from gw-nl4.philips.com ([212.153.190.6]:10731 "EHLO
	gw-nl4.philips.com") by vger.kernel.org with ESMTP id S263060AbTHVJoo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 05:44:44 -0400
Message-ID: <3F45E651.8000408@basmevissen.nl>
Date: Fri, 22 Aug 2003 11:45:53 +0200
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
Cc: Anders Karlsson <anders@trudheim.com>,
       Christian Axelsson <smiler@lanil.mine.nu>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Current status of Intel PRO/Wireless 2100
References: <3F3CA3A0.5030905@lanil.mine.nu> <1060942697.2296.83.camel@tor.trudheim.com> <3F421B6C.2050300@basmevissen.nl> <Pine.LNX.4.56.0308211327220.6793@filesrv1.baby-dragons.com>
In-Reply-To: <Pine.LNX.4.56.0308211327220.6793@filesrv1.baby-dragons.com>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. James W. Laferriere wrote:
> 	Hello Bas ,  Do you (or anyone else) know which of the 'PCI' based
> 	cards are use the 'mini-pci' cards on a bridge card ?
> 

Probably all PCI-cards that have a huge metal casing. PCI WLAN cards are 
not so common (desktop and wireless is a bit silly :-))and hence the 
development costs for a "real" PCI WLAN card might be too high compared 
to the extra cost of using a Mini-PCI and a bridge. Actually, "bridge" 
is too much honour for the remaining card. Slot converter is more 
appropriate.

> 	I'd really like more of a selection to choose from than just
> 	Netgear .  The Netgear card you spoke of below religously doesn't
> 	mention Linux in it's support sections .  But ,  (hopefully) it
> 	appears that you are using under linux , correct ?  Tia ,  JimL
> 

We all like that. Actually, I wanted to have an 802.11a/b/g from a 
supplier that has real open source drivers. But it was all I could get 
on a short term.

I use it with Linux. Actually, I did not more than a few tests. But I 
know it works and I verified it with the XP install that came with the 
notebook. I just had to install the PCI-card drivers there.

(general remark) Note that this kind of use of mini-pci modules is all 
on your own risk and responsibility. Maybe I better had not told this on 
LKML. But now that has happened, I advise people to think twice before 
doing it and ask me for details in private if they feel uncertain about it.

Regards,

Bas.




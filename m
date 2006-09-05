Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965101AbWIEPOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbWIEPOL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 11:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965104AbWIEPOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 11:14:11 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:42667 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965101AbWIEPOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 11:14:09 -0400
Message-ID: <44FD9431.2050403@garzik.org>
Date: Tue, 05 Sep 2006 11:13:53 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
CC: Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, greg@kroah.com, harmon@ksu.edu,
       Daniel Drake <dsd@gentoo.org>, Len Brown <len.brown@intel.com>
Subject: Re: VIA IRQ quirk, another (embarrassing) suggestion.
References: <1157330567.3046.24.camel@localhost.portugal>	 <20060903175841.7a84c63c.akpm@osdl.org> <44FBBD28.6070601@garzik.org>	 <20060904055502.GA26816@tuatara.stupidest.org>	 <1157370847.4624.15.camel@localhost.localdomain>	 <20060904183352.GA14004@tuatara.stupidest.org> <1157468155.30252.17.camel@localhost.localdomain>
In-Reply-To: <1157468155.30252.17.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergio Monteiro Basto wrote:
> On Mon, 2006-09-04 at 11:33 -0700, Chris Wedgwood wrote:
>> On Mon, Sep 04, 2006 at 12:54:07PM +0100, Sergio Monteiro Basto wrote:
>>
>>> I don't know if this is a real question. Have we VIA products on PCI
>>> card, running on not VIA chip sets ?
>> Yes.  Certainly for on-board devices too.
> 
> OK , other argument.
> We have billions of VIA chip sets with VIA PCI on-board and 
> VIA PCI on others chip sets, if exists, are a very few.
> So, because some exceptions, we shouldn't stop a resolution of a very
> large % of the cases. 

No thanks.  As VIA SATA maintainer, I like being able to use my VIA SATA 
PCI card.

	Jeff




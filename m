Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWIDMO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWIDMO2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 08:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWIDMO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 08:14:28 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:31106 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751349AbWIDMOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 08:14:22 -0400
Message-ID: <44FC1892.8010405@garzik.org>
Date: Mon, 04 Sep 2006 08:14:10 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
CC: Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, greg@kroah.com, harmon@ksu.edu,
       Daniel Drake <dsd@gentoo.org>, Len Brown <len.brown@intel.com>
Subject: Re: VIA IRQ quirk, another (embarrassing) suggestion.
References: <1157330567.3046.24.camel@localhost.portugal>	 <20060903175841.7a84c63c.akpm@osdl.org> <44FBBD28.6070601@garzik.org>	 <20060904055502.GA26816@tuatara.stupidest.org> <1157370847.4624.15.camel@localhost.localdomain>
In-Reply-To: <1157370847.4624.15.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergio Monteiro Basto wrote:
> I don't know if this is a real question. Have we VIA products on PCI
> card, running on not VIA chip sets ? 

A PCI card can be placed into any compatible system.

I test VIA SATA and VIA ethernet exclusively on non-VIA systems, simply 
because I don't have access to a VIA-based system anymore.

	Jeff



-- 
VGER BF report: H 0

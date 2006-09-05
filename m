Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWIEOzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWIEOzz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 10:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbWIEOzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 10:55:54 -0400
Received: from relay1.ptmail.sapo.pt ([212.55.154.21]:1491 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S964845AbWIEOzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 10:55:53 -0400
X-AntiVirus: PTMail-AV 0.3-0.88.4
Subject: Re: VIA IRQ quirk, another (embarrassing) suggestion.
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, greg@kroah.com, harmon@ksu.edu,
       Daniel Drake <dsd@gentoo.org>, Len Brown <len.brown@intel.com>
In-Reply-To: <20060904183352.GA14004@tuatara.stupidest.org>
References: <1157330567.3046.24.camel@localhost.portugal>
	 <20060903175841.7a84c63c.akpm@osdl.org> <44FBBD28.6070601@garzik.org>
	 <20060904055502.GA26816@tuatara.stupidest.org>
	 <1157370847.4624.15.camel@localhost.localdomain>
	 <20060904183352.GA14004@tuatara.stupidest.org>
Content-Type: text/plain; charset=utf-8
Date: Tue, 05 Sep 2006 15:55:55 +0100
Message-Id: <1157468155.30252.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-04 at 11:33 -0700, Chris Wedgwood wrote:
> On Mon, Sep 04, 2006 at 12:54:07PM +0100, Sergio Monteiro Basto wrote:
> 
> > I don't know if this is a real question. Have we VIA products on PCI
> > card, running on not VIA chip sets ?
> 
> Yes.  Certainly for on-board devices too.

OK , other argument.
We have billions of VIA chip sets with VIA PCI on-board and 
VIA PCI on others chip sets, if exists, are a very few.
So, because some exceptions, we shouldn't stop a resolution of a very
large % of the cases. 

Thanks,
--
Sérgio M. B. 


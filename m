Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751754AbWCLUmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbWCLUmZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 15:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbWCLUmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 15:42:25 -0500
Received: from xenotime.net ([66.160.160.81]:59787 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751754AbWCLUmY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 15:42:24 -0500
Date: Sun, 12 Mar 2006 12:44:12 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: GregScott@InfraSupportEtc.com, linux-kernel@vger.kernel.org,
       bart@samwel.tk
Subject: Re: Router stops routing after changing MAC Address
Message-Id: <20060312124412.34004d1d.rdunlap@xenotime.net>
In-Reply-To: <1142187253.20056.10.camel@localhost.localdomain>
References: <925A849792280C4E80C5461017A4B8A20321DD@mail733.InfraSupportEtc.com>
	<1142187253.20056.10.camel@localhost.localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Mar 2006 18:14:13 +0000 Alan Cox wrote:

> On Sul, 2006-03-12 at 09:34 -0600, Greg Scott wrote:
> > Bart and I had a private discussion about this.  I was able to prove
> > that routing stops when "fudged" MAC Addresses on the router don't match
> > the hardware MAC Addresses.  And routing starts back up again when the I
> > change the "fudged" MAC Addresses back to match the hardware MAC
> > Addresses.  
> 
> Which driver, and does it occur with other drivers. Also you really want
> to move this to netdev@oss.sgi.com to get the best network folks to see
> it.

that is now netdev@vger.kernel.org ....


---
~Randy
Please use an email client that implements proper (compliant) threading.
(You know who you are.)

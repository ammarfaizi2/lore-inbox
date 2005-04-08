Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVDHUoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVDHUoF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 16:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbVDHUoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 16:44:05 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:52407 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S261409AbVDHUoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 16:44:01 -0400
Subject: Re: PCI-Express not working/unuseable on Intel 925XE Chipset since
	2.6.12-rc1[mm1-4]
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Jacek Luczak <difrost@pin.if.uz.zgora.pl>
Cc: Michael Thonke <tk-shockwave@web.de>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <424D9FCE.6020200@pin.if.uz.zgora.pl>
References: <424D44F0.6090707@web.de> <424D5E2E.8040207@pin.if.uz.zgora.pl>
	 <424D71DE.5060703@web.de> <424D91B5.50404@pin.if.uz.zgora.pl>
	 <424D9A9C.2070705@web.de>  <424D9FCE.6020200@pin.if.uz.zgora.pl>
Content-Type: text/plain; charset=iso-8859-2
Date: Fri, 08 Apr 2005 14:43:59 -0600
Message-Id: <1112993039.12025.65.camel@eeyore>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-01 at 21:23 +0200, Jacek Luczak wrote:
> Michael Thonke napisa³(a):
> > Hello Jacek,
> > 
> > I finially got it working :-) my PCI-Express devices working now...
> > I grabbed the last bk-snapshot from kernel.org 2.6.12-rc1-bk3 and et volia
> > everything except the Marvell Yokon PCI-E device working.
> > I hope Andrew will look into the mm-line to find the bug?
> > 
> 
> I've got Marvell Yukon 88E8053 GigE and it works fine with fixed (by 
> myself :]) driver from syskonnect. If you wont I may send it to you!

Please post your patch here and copy the maintainers:

MARVELL YUKON / SYSKONNECT DRIVER
P:      Mirko Lindner
M:      mlindner@syskonnect.de
P:      Ralph Roesler
M:      rroesler@syskonnect.de
W:      http://www.syskonnect.com
S:      Supported



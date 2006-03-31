Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbWCaXiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWCaXiV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 18:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWCaXiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 18:38:21 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:3982 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751380AbWCaXiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 18:38:20 -0500
Subject: RE: IDE CMD 64x PCI driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Komuro <komurojun-mbn@nifty.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <27060187.14131143847493404.komurojun-mbn@nifty.com>
References: <27060187.14131143847493404.komurojun-mbn@nifty.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 01 Apr 2006 00:46:16 +0100
Message-Id: <1143848776.16133.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2006-04-01 at 08:24 +0900, Komuro wrote:
> Hello,
> 
> >I am having difficultly getting the IDE CMD 64x PCI driver to work for the
> >CMD PCI-648 device.  I have decided to dig through kernel and driver code
> >to find out why and hopefully correct the problem.
> 
> 
> 
> It seems nobody maintains the CMD64x driver.

I've been working on CMD648 support for the libata PATA set. I don't
have a CMD648 so testers would be most welcome.

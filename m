Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268040AbUHVR1C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268040AbUHVR1C (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 13:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268050AbUHVRYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 13:24:18 -0400
Received: from the-village.bc.nu ([81.2.110.252]:56719 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268040AbUHVRXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 13:23:44 -0400
Subject: Re: PROBLEM: Promise Fast Track SX6000 i2o driver.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Piotr Goczal <bilbo@mazurek.man.lodz.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0408221854310.2571@mazurek.man.lodz.pl>
References: <Pine.LNX.4.58.0408211012500.2571@mazurek.man.lodz.pl>
	 <1093173914.24272.45.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0408221606520.2571@mazurek.man.lodz.pl>
	 <1093184419.24617.5.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0408221854310.2571@mazurek.man.lodz.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093191690.24761.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 22 Aug 2004 17:21:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-08-22 at 17:55, Piotr Goczal wrote:
> On Sun, 22 Aug 2004, Alan Cox wrote:
> 
> > As I understand it the new firmware isn't I2O so I2O would be the wrong
> > driver anyway. If Promise own source code drivers support it then that
> > is at least as good as documentation 8). Are promise own drivers for the
> > sx6000 GPL or not ?
> 
> Fortunatelly: YES

Then I think that the right path is probably to integrate those drivers
into the kernel, cleaning them up if neccessary ?


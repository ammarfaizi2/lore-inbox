Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267460AbUHVPWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267460AbUHVPWc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 11:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267461AbUHVPWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 11:22:32 -0400
Received: from the-village.bc.nu ([81.2.110.252]:19855 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267460AbUHVPWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 11:22:30 -0400
Subject: Re: PROBLEM: Promise Fast Track SX6000 i2o driver.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Piotr Goczal <bilbo@mazurek.man.lodz.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0408221606520.2571@mazurek.man.lodz.pl>
References: <Pine.LNX.4.58.0408211012500.2571@mazurek.man.lodz.pl>
	 <1093173914.24272.45.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0408221606520.2571@mazurek.man.lodz.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093184419.24617.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 22 Aug 2004 15:20:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-08-22 at 15:12, Piotr Goczal wrote:
> The Promise driver (distributed via src) is common and is working for both 
> version of firmware.
> 
> So, as I've understood: there will be no working i2o drivers for SX6000 at 
> least to time when Promise publicize documentation to their hardware. 
> :-( Am I right? 

As I understand it the new firmware isn't I2O so I2O would be the wrong
driver anyway. If Promise own source code drivers support it then that
is at least as good as documentation 8). Are promise own drivers for the
sx6000 GPL or not ?

Alan


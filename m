Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266386AbUIAMyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266386AbUIAMyP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 08:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266391AbUIAMyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 08:54:14 -0400
Received: from the-village.bc.nu ([81.2.110.252]:2187 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266386AbUIAMyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 08:54:03 -0400
Subject: Re: Promise SX-6000 Pro on 2.6.8.1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matt <odinson@warcloud.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0408312351250.13904-100000@www.warcloud.net>
References: <Pine.LNX.4.21.0408312351250.13904-100000@www.warcloud.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094039515.2475.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 01 Sep 2004 12:51:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-01 at 05:56, Matt wrote:
> Hello
> 
> 	I have recently attempted to upgrade my kernel from 2.4.20 with
> the cryptography patches to 2.6.8.1.  My promise card as addressed by the
> i2o device does not seem to get set up correctly during boot or respond
> once initialized.  This card was working fine before the upgrade.

The I2O stuff in 2.6.x is still getting knocked into shape. The newer
promise firmwares also seem to have removed most of I2O so I'm working
on getting their non I2O driver working on 2.6 currently.


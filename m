Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVABPmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVABPmI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 10:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVABPlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 10:41:06 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:48813 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261261AbVABPlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 10:41:00 -0500
Subject: Re: Questions about the CMD640 and RZ1000 bugfix support options
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Anton Mitterer <cam@mathematica.scientia.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41D5D206.1040107@mathematica.scientia.net>
References: <41D5D206.1040107@mathematica.scientia.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104676209.15004.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 02 Jan 2005 14:36:57 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-12-31 at 22:26, Christoph Anton Mitterer wrote:
> Hi.
> 
> First of all: A happy new year in advance!
> 
> Now to my question:
> In the kernel-configuration there are the two options:
> CONFIG_BLK_DEV_CMD640        CMD640 chipset bugfix/support
> and
> CONFIG_BLK_DEV_RZ1000        RZ1000 chipset bugfix/support
> 
> At least the second of those two seems to cause some little slowdown 
> ("This may slow disk throughput by a few percent, but at least things 

They only trigger for the affected chipsets


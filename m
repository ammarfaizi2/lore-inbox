Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751517AbWH3FpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbWH3FpX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 01:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbWH3FpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 01:45:23 -0400
Received: from natlemon.rzone.de ([81.169.145.170]:64965 "EHLO
	natlemon.rzone.de") by vger.kernel.org with ESMTP id S1751516AbWH3FpW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 01:45:22 -0400
Date: Wed, 30 Aug 2006 07:44:33 +0200
From: Olaf Hering <olaf@aepfle.de>
To: David Lang <dlang@digitalinsight.com>
Cc: Michael Buesch <mb@bu3sch.de>, Greg KH <greg@kroah.com>,
       Oleg Verych <olecom@flower.upol.cz>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Sven Luther <sven.luther@wanadoo.fr>, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
Message-ID: <20060830054433.GA31375@aepfle.de>
References: <1156802900.3465.30.camel@mulgrave.il.steeleye.com> <Pine.LNX.4.63.0608290844240.30381@qynat.qvtvafvgr.pbz> <20060829183208.GA11468@kroah.com> <200608292104.24645.mb@bu3sch.de> <20060829201314.GA28680@aepfle.de> <Pine.LNX.4.63.0608291341060.30381@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0608291341060.30381@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, David Lang wrote:

> you are assuming that
> 
> 1. modules are enabled and ipw2200 is compiled as a module

No, why?

> 2. initrd or initramfs are in use

initramfs is always in use.

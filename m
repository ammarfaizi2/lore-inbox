Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbWH1XvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWH1XvE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 19:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWH1XvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 19:51:04 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:9118 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S964911AbWH1XvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 19:51:01 -0400
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: debian-kernel@lists.debian.org, Greg KH <greg@kroah.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060828230452.GA4393@powerlinux.fr>
References: <1156802900.3465.30.camel@mulgrave.il.steeleye.com>
	 <1156803102.3465.34.camel@mulgrave.il.steeleye.com>
	 <20060828230452.GA4393@powerlinux.fr>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 18:50:56 -0500
Message-Id: <1156809056.3465.37.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-29 at 01:04 +0200, Sven Luther wrote:
> Notice that mkinitrd-tools is dead, and will probably be removed from etch.
> 
> mkinitramfs-tools and yaird are the two currently used tools.

Yes ... I'm aware of that.  That's why this is a reference
implementation.  initramfs should be easier ... I just don't have any
initramfs systems at the moment, so I did what I had and could verify.

James



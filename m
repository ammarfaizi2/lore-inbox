Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbVJQHM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbVJQHM2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 03:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbVJQHM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 03:12:28 -0400
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:50450 "EHLO
	anchor-post-36.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750938AbVJQHM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 03:12:27 -0400
From: Felix Oxley <lkml@oxley.org>
To: Rob Landley <rob@landley.net>
Subject: Re: [PATCH 1/1] Kconfig help text for RAM Disk & initrd
Date: Mon, 17 Oct 2005 08:12:10 +0100
User-Agent: KMail/1.8.2
References: <200510170102.19717.lkml@oxley.org> <200510170037.37034.rob@landley.net>
In-Reply-To: <200510170037.37034.rob@landley.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510170812.11590.lkml@oxley.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 October 2005 06:37, Rob Landley wrote:

> Actually if this is a patch against 2.6, between ramfs (including initramfs) 
> and the ability to loopback mount files, I personally consider ramdisks 
> semi-obsolete.  (This might be _why_ it says most normal users won't need 
> them.)

Well, you may well know better than I, however on my Suse 10 box, 
initrd is used and I see only CONFIG_INITRAMFS_SOURCE="" in my .config.

I made this patch because omiting intrd caused my system to be unable to boot.

regards,
Felix


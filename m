Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269620AbUJGAEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269620AbUJGAEs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 20:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269561AbUJGAAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 20:00:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:11750 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269600AbUJFX6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 19:58:48 -0400
Date: Wed, 6 Oct 2004 17:02:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: ak@muc.de, jgarzik@pobox.com, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [ink@jurassic.park.msu.ru: Re: [PATCH] Sort generic PCI fixups
 after specific ones]
Message-Id: <20041006170228.1f8e5efd.akpm@osdl.org>
In-Reply-To: <20041006201311.GG16153@parcelfarce.linux.theplanet.co.uk>
References: <20041006201311.GG16153@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <matthew@wil.cx> wrote:
>
> Greg asked me to resend this patch and cc l-k, so here it is.

Does this make
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm2/broken-out/sort-generic-pci-fixups-after-specific-ones.patch
obsolete, or what?

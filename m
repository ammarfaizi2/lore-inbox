Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWIIPwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWIIPwx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 11:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWIIPwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 11:52:53 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59882 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932279AbWIIPww
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 11:52:52 -0400
Subject: Re: [PATCH] alim15x3.c: M5229 (rev c8) support for DMA cd-writer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael De Backer <micdb@skynet.be>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org, akpm@osdl.org
In-Reply-To: <1157816221.5998.51.camel@mws.local.net>
References: <1157816221.5998.51.camel@mws.local.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 09 Sep 2006 17:15:25 +0100
Message-Id: <1157818525.6877.57.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-09-09 am 17:37 +0200, ysgrifennodd Michael De Backer:
> -       else if (m5229_revision == 0xc7)
> +       else if (m5229_revision == 0xc7 || 0xc8)

I don't think that is what you mean..

NAK


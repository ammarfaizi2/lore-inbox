Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965343AbWHOJ6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965343AbWHOJ6M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 05:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965318AbWHOJ6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 05:58:12 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:62921 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965343AbWHOJ6L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 05:58:11 -0400
Subject: Re: Intel 945PM/GM Ultra DMA support?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dmitry Bohush <dmitrij.bogush@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2ac89c700608150118p5d7ed2cfq6191f8e32cdd79e7@mail.gmail.com>
References: <2ac89c700608150118p5d7ed2cfq6191f8e32cdd79e7@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 15 Aug 2006 11:18:46 +0100
Message-Id: <1155637126.24077.238.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-15 am 11:18 +0300, ysgrifennodd Dmitry Bohush:
> I was not able to set udma5 mode on this chipset with latest kernel.
> In logs I get messages like: "3/4/5 is not functional!".

Please can you quote the actual boot up messages (or stick them
somewhere). My first guess would be that you don't have an 80 wire cable
- or something is detecting that you dont.


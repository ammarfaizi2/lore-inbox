Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbVJAJmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbVJAJmL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 05:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVJAJmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 05:42:11 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:61648 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1750782AbVJAJmK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 05:42:10 -0400
Subject: Re: [PATCH] [BLUETOOTH] kmalloc + memset -> kzalloc conversion
From: Marcel Holtmann <marcel@holtmann.org>
To: dsaxena@plexity.net
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       maxk@qualcomm.com, linux-kernel@vger.kernel.org
In-Reply-To: <20051001065121.GC25424@plexity.net>
References: <20051001065121.GC25424@plexity.net>
Content-Type: text/plain
Date: Sat, 01 Oct 2005 11:42:09 +0200
Message-Id: <1128159729.8555.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Deepak,

> Signed-off-by: Deepak Saxena <dsaxena@plexity.net>
> 
> 
> diff --git a/drivers/block/DAC960.c b/drivers/block/DAC960.c

this is not the patch for the Bluetooth drivers.

Regards

Marcel



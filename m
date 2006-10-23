Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965065AbWJWTVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbWJWTVV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 15:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbWJWTVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 15:21:21 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45266 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965065AbWJWTVU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 15:21:20 -0400
Subject: Re: [KJ][PATCH] Correct misc_register return code handling in
	several drivers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Neil Horman <nhorman@tuxdriver.com>
Cc: kernel-janitors@lists.osdl.org, kjhall@us.ibm.com, akpm@osdl.org,
       benh@kernel.crashing.org, maxk@qualcomm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061023175427.GB23714@hmsreliant.homelinux.net>
References: <20061023171910.GA23714@hmsreliant.homelinux.net>
	 <1161625164.21701.18.camel@localhost.localdomain>
	 <20061023175427.GB23714@hmsreliant.homelinux.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 23 Oct 2006 20:18:15 +0100
Message-Id: <1161631095.22348.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-23 am 13:54 -0400, ysgrifennodd Neil Horman:
> On Mon, Oct 23, 2006 at 06:39:24PM +0100, Alan Cox wrote:
> New patch attached, taking Alan's suggestions into account.  I'll consolidate
> the printk error messages into misc_register in a later patch when I have a
> moment.  Thanks Alan.
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>

Acked-by: Alan Cox <alan@redhat.com>



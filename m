Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752860AbWKBL33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860AbWKBL33 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 06:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752858AbWKBL33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 06:29:29 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48301 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1752855AbWKBL32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 06:29:28 -0500
Subject: Re: [PATCH 1/2] IDE: Add the support of nvidia PATA controllers of
	MCP67 to amd74xx.c & pata_amd.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Peer Chen <pchen@nvidia.com>, akpm@osdl.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B0C54FBA7@hkemmail01.nvidia.com>
References: <15F501D1A78BD343BE8F4D8DB854566B0C54FBA7@hkemmail01.nvidia.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 02 Nov 2006 11:32:20 +0000
Message-Id: <1162467141.11965.160.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-11-02 am 11:30 +0800, ysgrifennodd Peer Chen:
> Add support for PATA controllers of MCP67 to amd74xx.c.
> The patch will be applied to kernel 2.6.19-rc4-git1.
> Please check attachment for the patch.
> 
> Signed-off-by: Peer Chen <pchen@nvidia.com>

Acked-by: Alan Cox <alan@redhat.com>

Andrew - it would be good if these two patches + ahci one could make
2.6.19 final as they are just ident updates for chipsets.

Alan


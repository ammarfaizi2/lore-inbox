Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbTI2LuR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 07:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263179AbTI2LuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 07:50:17 -0400
Received: from [66.212.224.118] ([66.212.224.118]:27667 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S263178AbTI2LuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 07:50:15 -0400
Date: Mon, 29 Sep 2003 07:50:13 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [PATCH][CFT] atp870u pci driver update
In-Reply-To: <Pine.LNX.4.53.0309290228130.1740@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.53.0309290749500.1740@montezuma.fsmlabs.com>
References: <Pine.LNX.4.53.0309290228130.1740@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have reason to believe this patch might be leaking Scsi_Hosts, i'll send 
an updated one shortly.

Thanks

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbWALC02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWALC02 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 21:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbWALC01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 21:26:27 -0500
Received: from PPP-219.65.138.139.bgl.dialup.vsnl.net.in ([219.65.138.139]:28683
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S932676AbWALC01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 21:26:27 -0500
Date: Thu, 12 Jan 2006 07:56:22 +0530 (IST)
From: "Rajeev V. Pillai" <rajeevvp@yahoo.com>
X-X-Sender: rvp@localhost.localdomain
To: linux-kernel@vger.kernel.org
Subject: Removal of PCI_VENDOR_ID_RENDITION from 2.6.15
Message-ID: <Pine.LNX.4.64.0601120752320.1259@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why were the RENDITION related PCI Vendor and device IDs removed from
2.6.15?  Svgalib, for one, depends on it.

Thanks,
Rajeev

PS. I'm not on the mailing list, so, please CC when replying.

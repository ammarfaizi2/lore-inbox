Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbVAMPqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVAMPqP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 10:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVAMPmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 10:42:35 -0500
Received: from ms-2.rz.RWTH-Aachen.DE ([134.130.3.131]:37005 "EHLO
	ms-dienst.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S261679AbVAMPkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 10:40:52 -0500
Date: Mon, 22 Oct 2001 20:45:22 +0200 (CEST)
From: jarausch@belgacom.net
Subject: 2.4.13-pre6 breaks Nvidia's kernel module
To: linux-kernel@vger.kernel.org
Reply-to: jarausch@belgacom.net
Message-id: <20050113151050.051BEFEC0E@numa-i.igpm.rwth-aachen.de>
MIME-version: 1.0
Content-type: TEXT/PLAIN; CHARSET=us-ascii
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

yes I know, you don't like modules without full sources available.
But Nvidia is the leading vendor of video cards and all 2.4.x
kernels up to 2.4.13-pre5 work nice with this module.

Running pre6 I get
(==) NVIDIA(0): Write-combining range (0xf0000000,0x2000000)
(EE) NVIDIA(0): Failed to allocate LUT context DMA
(EE) NVIDIA(0):  *** Aborting ***


This is Nvidia's 1.0-1541 version of its Linux drivers

Please keep this driver going during the 2.4.x series of the
kernel if at all possible.

Thanks for looking into it,

Helmut Jarausch

Inst. of Technology
RWTH Aachen
Germany


Please CC to my private email

jarausch@belgacom.net




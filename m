Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbTIQQap (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 12:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbTIQQap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 12:30:45 -0400
Received: from ferengi.skynet.be ([195.238.2.126]:42406 "EHLO
	ferengi.skynet.be") by vger.kernel.org with ESMTP id S261498AbTIQQan
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 12:30:43 -0400
Date: Mon, 22 Oct 2001 20:45:22 +0200 (CEST)
From: jarausch@belgacom.net
Reply-To: jarausch@belgacom.net
Subject: 2.4.13-pre6 breaks Nvidia's kernel module
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Message-Id: <20030917161951.6B8FDBC017@numa.skynet.be>
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



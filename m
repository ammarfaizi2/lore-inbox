Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276907AbRJVSq3>; Mon, 22 Oct 2001 14:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277601AbRJVSqJ>; Mon, 22 Oct 2001 14:46:09 -0400
Received: from riker.skynet.be ([195.238.3.132]:11638 "EHLO riker.skynet.be")
	by vger.kernel.org with ESMTP id <S276907AbRJVSqE>;
	Mon, 22 Oct 2001 14:46:04 -0400
Message-Id: <200110221846.f9MIkE416013@riker.skynet.be>
Date: Mon, 22 Oct 2001 20:45:22 +0200 (CEST)
From: jarausch@belgacom.net
Reply-To: jarausch@belgacom.net
Subject: 2.4.13-pre6 breaks Nvidia's kernel module
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
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



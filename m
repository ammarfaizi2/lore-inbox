Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316953AbSFWBcB>; Sat, 22 Jun 2002 21:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316954AbSFWBcB>; Sat, 22 Jun 2002 21:32:01 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49169 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316953AbSFWBcA>; Sat, 22 Jun 2002 21:32:00 -0400
Subject: Re: 2.5.21 : PCI DMA conversions needed
To: fdavis@si.rr.com (Frank Davis)
Date: Sun, 23 Jun 2002 02:54:26 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, fdavis@si.rr.com
In-Reply-To: <Pine.LNX.4.33.0206131418530.927-100000@localhost.localdomain> from "Frank Davis" at Jun 13, 2002 02:23:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17LwaA-0003f7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   The following files have been identified as requiring conversions to the 
> current DMA API, as defined in Documentation/DMA-mapping.txt . If anyone 
> has a conversion process, please let me know. Thanks.

The i2o ones are on my list. Once a 2.5 kernel actuallty boots and runson
my i2o test box I'll look into it

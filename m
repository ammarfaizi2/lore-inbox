Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311803AbSCNV1i>; Thu, 14 Mar 2002 16:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311802AbSCNV1a>; Thu, 14 Mar 2002 16:27:30 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14611 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311803AbSCNV1W>; Thu, 14 Mar 2002 16:27:22 -0500
Subject: Re: K7S5A SIS735 ext2fs corruption
To: drf5n@mug.sys.virginia.edu (David Forrest)
Date: Thu, 14 Mar 2002 21:43:01 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0203142014160.7770-100000@mug.sys.virginia.edu> from "David Forrest" at Mar 14, 2002 08:38:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ld01-0001wz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> lkml: 2001-12-30 UMOUNTING in 2.4.17 / Ext2 Partitions destroyed (3x)
> lkml: 2001-10-25 Repeatable File Corruption (ECS K7S5A w/SIS735)

Please try 2.4.19pre3 - Lionel has been doing sterling work updating all the
SIS drivers. If you still have a problem with the update we *really* want
to know about it


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268289AbUIGUHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268289AbUIGUHg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 16:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268525AbUIGT7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 15:59:17 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:8428 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S268346AbUIGT5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 15:57:13 -0400
From: Lorenzo Allegrucci <l_allegrucci@yahoo.it>
Organization: -ENOENT
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc1-mm4
Date: Tue, 7 Sep 2004 22:01:54 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20040907020831.62390588.akpm@osdl.org>
In-Reply-To: <20040907020831.62390588.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409072201.55025.l_allegrucci@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 September 2004 11:08, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6
>.9-rc1-mm4/

My PS/2 keyboard doesn't work, I tried "pci=routeirq" but it didn't help.

Sep  7 21:39:00 odyssey kernel: i8042: ACPI  [PS2K] at I/O 0x0, 0x0, irq 1
Sep  7 21:39:00 odyssey kernel: i8042: ACPI  [PS2M] at irq 12
Sep  7 21:39:00 odyssey kernel: i8042.c: Can't read CTR while initializing 
i8042.

-- 
Lorenzo

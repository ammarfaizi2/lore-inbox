Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291900AbSBTPKo>; Wed, 20 Feb 2002 10:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291903AbSBTPKf>; Wed, 20 Feb 2002 10:10:35 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13833 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291900AbSBTPKQ>; Wed, 20 Feb 2002 10:10:16 -0500
Subject: Re: 2.4.18-rcx: Dual P3 + VIA + APIC
To: adam@os.inf.tu-dresden.de (Adam Lackorzynski)
Date: Wed, 20 Feb 2002 15:24:38 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020220104129.GP13774@os.inf.tu-dresden.de> from "Adam Lackorzynski" at Feb 20, 2002 11:41:29 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16dYbm-0003pu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> trying to boot a 2.4.18-rc1, 2.4.18-rc2-ac1 or 2.5.5pre1 on a dual P3
> with a VIA chipset hangs (randomly) at the "=====" signs, sometimes the
> screen is flickering:

Does 2.4.18pre8 work ? There is a small MP 1.4 change I tested and fed on
to Marcelo and it would be nice to know that wasnt the cause

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287102AbRL2Crm>; Fri, 28 Dec 2001 21:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287099AbRL2Crc>; Fri, 28 Dec 2001 21:47:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54286 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287105AbRL2Cr2>; Fri, 28 Dec 2001 21:47:28 -0500
Subject: Re: zImage not supported for 2.2.20?
To: hpa@zytor.com (H. Peter Anvin)
Date: Sat, 29 Dec 2001 02:58:01 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <a0j9i2$tkr$1@cesium.transmeta.com> from "H. Peter Anvin" at Dec 28, 2001 06:25:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16K9hB-0002pt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Machine/motherboard/chipset/BIOS info?

Might be worth waiting for 2.2.21pre1 - my patch assembling turned up a
pending diff related to zImage boot crashes.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263914AbTK2RHW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 12:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263921AbTK2RHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 12:07:21 -0500
Received: from legolas.restena.lu ([158.64.1.34]:24235 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S263914AbTK2RHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 12:07:17 -0500
Subject: Re: Silicon Image 3112A SATA trouble
From: Craig Bradney <cbradney@zip.com.au>
To: Julien Oster <frodoid@frodoid.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <frodoid.frodo.878ylzjfjm.fsf@usenet.frodoid.org>
References: <3FC36057.40108@gmx.de> <3FC8BDB6.2030708@gmx.de>
	 <frodoid.frodo.878ylzjfjm.fsf@usenet.frodoid.org>
Content-Type: text/plain
Message-Id: <1070125634.28187.11.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 29 Nov 2003 18:07:14 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I can't find the Silicon Image driver under
> 
> "SCSI low-level drivers" -> "Serial ATA (SATA) support"
> 
> under 2.6.0-test11. Just the following are there:
> 
> ServerWorks Frodo
> Intel PIIX/ICH
> Promisa SATA
> VIA SATA
> 

Try under ATA/ATAPI/MFM/RLL support

Silicon Image Chipset Support
CONFIG_BLK_DEV_SIIMAGE:                                                                           This driver adds PIO/(U)DMA support for the SI CMD680 and SII 3112 (Serial ATA) chips.

Craig




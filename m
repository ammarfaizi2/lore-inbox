Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290769AbSBTBlI>; Tue, 19 Feb 2002 20:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290772AbSBTBk7>; Tue, 19 Feb 2002 20:40:59 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24325 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290769AbSBTBkr>; Tue, 19 Feb 2002 20:40:47 -0500
Subject: Re: Hot swap for SCSI drives in 2.4.16
To: inglem@cisco.com (Mukund Ingle)
Date: Wed, 20 Feb 2002 01:54:37 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4.2.0.58.20020219162903.01657ea0@bulkrate.cisco.com> from "Mukund Ingle" at Feb 19, 2002 04:34:01 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16dLxt-0002CG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does 2.4.16 Kernel support hot-swapping and
> hot-pluggable (plugging in new drive) feature for
> SCSI drives.

All 2.2/2.4 kernels do with most controllers. Providing you have proper scsi
hot swap capable bays. I think 2.0 also does

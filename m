Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289959AbSAKOIy>; Fri, 11 Jan 2002 09:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289961AbSAKOIo>; Fri, 11 Jan 2002 09:08:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8965 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289959AbSAKOIe>; Fri, 11 Jan 2002 09:08:34 -0500
Subject: Re: Big patch: linux-2.5.2-pre11/drivers/scsi compilation fixes
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Fri, 11 Jan 2002 14:20:06 +0000 (GMT)
Cc: axboe@suse.de (Jens Axboe), adam@yggdrasil.com (Adam J. Richter),
        linux-kernel@vger.kernel.org
In-Reply-To: <3C3EEC94.7020001@evision-ventures.com> from "Martin Dalecki" at Jan 11, 2002 02:45:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16P2XO-0007lf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unless you started with the 2.4.17/2.4.18pre for most of the NCR5380 based
drivers don't bother. The one in 2.5 doesn't even work in 2.2 SMP

Alan

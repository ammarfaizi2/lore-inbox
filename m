Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262985AbTCWJQQ>; Sun, 23 Mar 2003 04:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262986AbTCWJQQ>; Sun, 23 Mar 2003 04:16:16 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:12805 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S262985AbTCWJQQ>; Sun, 23 Mar 2003 04:16:16 -0500
Date: Sun, 23 Mar 2003 10:27:19 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE todo list
Message-ID: <20030323092719.GB3818@merlin.emma.line.org>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1048352492.9219.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048352492.9219.4.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Mar 2003, Alan Cox wrote:

> -	Add ATAPI virtual DMA
> -	Add DMA active irq poll trick
 ...
> -	ADMA full support
> -	Mark Lord/Andre ideas on LBA28/LBA48

Will anything of this enable SG_IO via IDE-SCSI to do DMA with 2448 or
2352 bytes per block, or have other means to reduce the system load
when writing a CD?

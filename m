Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286730AbRLVIq2>; Sat, 22 Dec 2001 03:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286731AbRLVIqP>; Sat, 22 Dec 2001 03:46:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46856 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286730AbRLVIqC>; Sat, 22 Dec 2001 03:46:02 -0500
Subject: Re: IDE Harddrive Performance
To: akeys@post.cis.smu.edu (Adam Keys)
Date: Sat, 22 Dec 2001 08:56:06 +0000 (GMT)
Cc: thomas@deselaers.de (Thomas Deselaers), linux-kernel@vger.kernel.org
In-Reply-To: <20011222082147.CCTE6450.rwcrmhc52.attbi.com@there> from "Adam Keys" at Dec 22, 2001 02:21:59 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Hhws-0003Rj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> # hdparm -t /dev/hda
> 
> /dev/hda:
>  Timing buffered disk reads:  64 MB in 86.98 seconds =753.46 kB/sec

Do you get sane numbers if you use 2.4.9 for the hdparm test ?

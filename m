Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289792AbSBEUn7>; Tue, 5 Feb 2002 15:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289789AbSBEUnt>; Tue, 5 Feb 2002 15:43:49 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49936 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289787AbSBEUn3>; Tue, 5 Feb 2002 15:43:29 -0500
Subject: Re: one-line-patch against SCSI-Read-Error-BUG()
To: R.Oehler@GDAmbH.com (Ralf Oehler)
Date: Tue, 5 Feb 2002 20:56:43 +0000 (GMT)
Cc: linux-scsi@vger.kernel.org (Scsi), linux-kernel@vger.kernel.org,
        andrea@suse.de (Andrea Arcangeli), axboe@kernel.org (Jens Axboe),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <XFMail.20020205153210.R.Oehler@GDAmbH.com> from "Ralf Oehler" at Feb 05, 2002 03:32:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16YCdv-0002ru-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Since at least kernel 2.4.16 there is a BUG() in pci.h,
> that crashes the kernel on any attempt to read a SCSI-Sector
> from an erased MO-Medium and on any attempt to read
> a sector from a SCSI-disk, which returns "Read-Error".

Adaptec aic7xxx card ?

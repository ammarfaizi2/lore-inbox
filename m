Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291224AbSAaSka>; Thu, 31 Jan 2002 13:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291225AbSAaSkU>; Thu, 31 Jan 2002 13:40:20 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33295 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291224AbSAaSkM>; Thu, 31 Jan 2002 13:40:12 -0500
Subject: Re: BusLogic build error in 2.5.3
To: tsullivan@datawest.net (Tim Sullivan)
Date: Thu, 31 Jan 2002 18:53:11 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1012501663.1349.20.camel@prostock.ecom-tech.com> from "Tim Sullivan" at Jan 31, 2002 11:27:42 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16WMKd-0002uR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> According to a note in the scsi_obsolete.c file, "Once the last
> driver uses the new code this *ENTIRE* file will be nuked."
> 
> It seems that scsi_obsolete.c has been "nuked" prematurely :)

If someone has deleted it I applaud them 8). The scsi_obsolete stuff goes
back to 2.2 era and not enough people have jumped. Time to remind them that
the service they are currently using is four years into its phase out and
now going away

Alan

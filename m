Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264660AbUFQCuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264660AbUFQCuY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 22:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266113AbUFQCuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 22:50:24 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:7161 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264660AbUFQCuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 22:50:21 -0400
From: Markus Kossmann <markus.kossmann@inka.de>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.7] new NVIDIA libata SATA driver
Date: Thu, 17 Jun 2004 04:49:35 +0200
User-Agent: KMail/1.6.2
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF043984B1@mail-sc-6-bk.nvidia.com> <200406170312.42324.bzolnier@elka.pw.edu.pl> <20040617012009.GA10879@havoc.gtf.org>
In-Reply-To: <20040617012009.GA10879@havoc.gtf.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406170449.37566.markus.kossmann@inka.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:c61bb2ac26f0036f61bd70b4ba33295f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 17. Juni 2004 03:20 schrieben Sie:
[...]
> Then, I'll apply a patch that adds Kconfig questions
>
> 	Include hardware that conflicts with libata SATA driver?
> 	(in drivers/ide)
> and
> 	Include hardware that conflicts with IDE driver?
> 	(in libata, drivers/scsi)
>
> and apply the associated ifdefs to the low-level drivers.
>
This patch will address the conflict between sata_sil and siimage, too ? 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266360AbUFQDOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266360AbUFQDOQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 23:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266231AbUFQDOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 23:14:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8656 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266230AbUFQDON
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 23:14:13 -0400
Message-ID: <40D10C75.80506@pobox.com>
Date: Wed, 16 Jun 2004 23:13:57 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Markus Kossmann <markus.kossmann@inka.de>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.7] new NVIDIA libata SATA driver
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF043984B1@mail-sc-6-bk.nvidia.com> <200406170312.42324.bzolnier@elka.pw.edu.pl> <20040617012009.GA10879@havoc.gtf.org> <200406170449.37566.markus.kossmann@inka.de>
In-Reply-To: <200406170449.37566.markus.kossmann@inka.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Kossmann wrote:
> Am Donnerstag, 17. Juni 2004 03:20 schrieben Sie:
> [...]
> 
>>Then, I'll apply a patch that adds Kconfig questions
>>
>>	Include hardware that conflicts with libata SATA driver?
>>	(in drivers/ide)
>>and
>>	Include hardware that conflicts with IDE driver?
>>	(in libata, drivers/scsi)
>>
>>and apply the associated ifdefs to the low-level drivers.
>>
> 
> This patch will address the conflict between sata_sil and siimage, too ? 

Yep.

	Jeff




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030249AbWFARWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbWFARWd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 13:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbWFARWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 13:22:33 -0400
Received: from rtr.ca ([64.26.128.89]:53941 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1030252AbWFARWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 13:22:32 -0400
Message-ID: <447F2257.4000404@rtr.ca>
Date: Thu, 01 Jun 2006 13:22:31 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Grant Coady <gcoady.lk@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Query: No IDE DMA for IBM 365X with PIIX chipset?
References: <j9bi729h2u4dcn9da7na3t1d8ckk477d9b@4ax.com> <1149169812.12932.20.camel@localhost>
In-Reply-To: <1149169812.12932.20.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>
> 82371FB, whee thats prehistoric 8)
> 
> I don't actually have any support for the 371FB PIIX in either driver as
> I've not been able to find a source for the data sheet to the chip. It
> may work if added to the drivers/scsi/pata_oldpiix identifiers in the
> 2.6.17rc5-mm kernel. Would be useful to know as I don't know anyone else
> with that chip any more 8)

That's the original Intel "triton" chipset.
I have a spare printed Intel document for the chipset (Intel #290519-001)
which I can mail you (Alan).  Email me privately with a postal address.

Cheers

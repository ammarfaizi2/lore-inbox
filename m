Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbUCLUfN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 15:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbUCLUbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 15:31:47 -0500
Received: from mtagate7.de.ibm.com ([195.212.29.156]:28669 "EHLO
	mtagate7.de.ibm.com") by vger.kernel.org with ESMTP id S262497AbUCLUbG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 15:31:06 -0500
Subject: Re: [PATCH] s390 (9/10): zfcp log messages part 1.
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OFF4F1554E.7176B1A5-ONC1256E55.00709267-C1256E55.0070A777@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Fri, 12 Mar 2004 21:30:29 +0100
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 12/03/2004 21:30:30
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Hi Christoph,

> > zfcp host adapter log message cleanup part 1:
> >  - Shorten log output.
> >  - Increase log level for some messages.
> >  - Always print leading zeroes for wwpn and fcp-lun.
>
> Is there any reason zfcp can't use dev_printk, sdev_printk & co?

Probably. I'll have to ask the scsi folks.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com



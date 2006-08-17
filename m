Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbWHQOEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbWHQOEV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 10:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbWHQOEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 10:04:21 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:4528 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965018AbWHQOET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 10:04:19 -0400
Message-ID: <44E47761.1080407@garzik.org>
Date: Thu, 17 Aug 2006 10:04:17 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: mikepolniak <mikpolniak@adelphia.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: JMicron SATA/IDE and 2.6.18-rc4 fails to detect CDROM
References: <20060817140115.GA3808@debamd64>
In-Reply-To: <20060817140115.GA3808@debamd64>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mikepolniak wrote:
> Using 2.6.18-rc4 and CONFIG_SCSI_SATA_AHCI=m, fails to detect ide cdrom.
> 
> lspci
> 
> 03:00.1 IDE interface: JMicron Technologies, Inc. JMicron 20360/20363
> AHCI
> Controller (rev02)

is it a SATA or PATA cdrom?

	Jeff




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262841AbVA2Bc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262841AbVA2Bc3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 20:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262842AbVA2Bc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 20:32:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26791 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262841AbVA2Bbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 20:31:55 -0500
Message-ID: <41FAE77D.9050903@pobox.com>
Date: Fri, 28 Jan 2005 20:31:41 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martins Krikis <mkrikis@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH, 2.4] fix an oops in ata_to_sense_error
References: <87ekg5e9j1.fsf@yahoo.com>
In-Reply-To: <87ekg5e9j1.fsf@yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martins Krikis wrote:
> Jeff,
> 
> This fixes an occasional oops in the libata-scsi code.
> 
>   Martins Krikis
> 
> --- linux-2.4.29/drivers/scsi/libata-scsi.c	2005-01-28 12:07:56.000000000 -0500
> +++ linux-2.4.29-iswraid/drivers/scsi/libata-scsi.c	2005-01-28 12:14:43.000000000 -0500


BTW, don't forget your signed-off-by line when submitting emails...

http://linux.yyz.us/patch-format.html

	Jeff



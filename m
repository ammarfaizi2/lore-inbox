Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbVCPSjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbVCPSjg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 13:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbVCPSiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 13:38:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3266 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262734AbVCPSfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 13:35:53 -0500
Message-ID: <42387C7C.9040407@pobox.com>
Date: Wed, 16 Mar 2005 13:35:40 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] SCSI updates for 2.6.11
References: <1110934411.5685.39.camel@mulgrave>
In-Reply-To: <1110934411.5685.39.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> This is my current tranch of patches that were waiting the transition
> from -rc to released (sorry it's late ... I've been on holiday).
> 
> The patch is available here:
> 
> bk://linux-scsi.bkbits.net/scsi-for-linus-2.6

Are my 3ware bugfixes in the queue?  Currently 3ware claims it handled 
the interrupt, even the interrupt is a shared one and the event was 
meant for another driver.

	Jeff




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbULKIMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbULKIMX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 03:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbULKIMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 03:12:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32942 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261840AbULKIMV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 03:12:21 -0500
Message-ID: <41BAABDF.3020709@pobox.com>
Date: Sat, 11 Dec 2004 03:12:15 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: maxer1 <maxer1@xmission.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: WHOOPS - linux-2.6.10-rc3 fails on ata_piix module
References: <41BA5EAF.4090908@xmission.com>
In-Reply-To: <41BA5EAF.4090908@xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

maxer1 wrote:
> WARNING: No module ata_piix found for kernel 2.6.10-rc3, continuing anyway
> 2.6.9 works great here.
> What is wrong here?

Mainly a distinct lack of information in your bug report.  See 
REPORTING-BUGS in the kernel source tree for information.

The ata_piix driver certainly didn't go away...

	Jeff




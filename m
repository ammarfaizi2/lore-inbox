Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWCVDI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWCVDI6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 22:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWCVDI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 22:08:58 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:65469 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750705AbWCVDI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 22:08:57 -0500
Message-ID: <4420BFBC.7080804@pobox.com>
Date: Tue, 21 Mar 2006 22:08:44 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dan Williams <dan.j.williams@gmail.com>
CC: Adrian Bunk <bunk@stusta.de>, Dan Williams <dan.j.williams@intel.com>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: drivers/scsi/sata_vsc.c: inconsistent NULL checking
References: <20060309110207.GA4006@stusta.de>	 <e9c3a7c20603091144sb078d92tcc232db66492e6c9@mail.gmail.com> <e9c3a7c20603091241y571e552p82c5c8091095c421@mail.gmail.com>
In-Reply-To: <e9c3a7c20603091241y571e552p82c5c8091095c421@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.5 (--)
X-Spam-Report: SpamAssassin version 3.0.5 on srv5.dvmed.net summary:
	Content analysis details:   (-2.5 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams wrote:
>>The attached patch cleans up the code, and adds GD31244 to the driver
>>description in drivers/scsi/Kconfig.

> Joe Perches suggested some coding style changes.  Here is version 2.

Applied.  When resending patches, please continue to follow the standard 
patch submission format, particularly #2, #5 and #6:
	http://linux.yyz.us/patch-format.html

Regards,

	Jeff



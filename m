Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVANFvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVANFvy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 00:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVANFvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 00:51:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20373 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261326AbVANFvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 00:51:52 -0500
Message-ID: <41E75DE5.4020108@pobox.com>
Date: Fri, 14 Jan 2005 00:51:33 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mitch Sako <msako@cadence.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: libata 2.6.10 limitation?
References: <6.1.2.0.2.20050113163537.03cb9208@mailhub>
In-Reply-To: <6.1.2.0.2.20050113163537.03cb9208@mailhub>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mitch Sako wrote:
> 
>> Is there a limitation to the number of SATA drives for libata that can 
>> be loaded to a 32bit Intel machine running 2.6.10?  I'm trying to 
>> setup six JBOD drives using 3 Promise cards or 3 Silicon Image cards 
>> or 2 Promise TX4 cards and I'm seeing a problem with /dev/sde (the 
>> fifth drive out of six) only.  I'm getting SCSI errors and machine 
>> hangs on the fifth drive only.

There is no limitation to the number of cards or devices.

	Jeff




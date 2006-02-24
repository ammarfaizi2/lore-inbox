Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWBXBzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWBXBzL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 20:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWBXBzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 20:55:11 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:52958 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932346AbWBXBzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 20:55:10 -0500
Date: Thu, 23 Feb 2006 19:54:50 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: CRC errors with sata drives connected to ULi M5281
In-reply-to: <5JsMw-3GG-389@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43FE676A.8030407@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5JsMw-3GG-389@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philip Langdale wrote:
> My symptoms appear identical to the ones described here:
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0503.2/1378.html
> 
>> ata13: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
>> ata13: status=0x51 { DriveReady SeekComplete Error }
>> ata13: error=0x84 { DriveStatusError BadCRC }

Sure you don't have a bad SATA cable?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030277AbWADUZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbWADUZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 15:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965281AbWADUZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 15:25:27 -0500
Received: from imo-m21.mx.aol.com ([64.12.137.2]:53901 "EHLO
	imo-m21.mx.aol.com") by vger.kernel.org with ESMTP id S965279AbWADUZ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 15:25:26 -0500
Message-ID: <43BC2F1A.9030200@aol.com>
Date: Wed, 04 Jan 2006 15:24:58 -0500
From: andy liebman <andyliebman@aol.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: chaosite@gmail.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Atapi CDROM, SATA OS drive, and 2.6.14+ kernel
References: <8C7DF7FCD8430A9-C8C-4BB2@MBLK-M38.sysops.aol.com> <43BC2C75.70202@gmail.com>
In-Reply-To: <43BC2C75.70202@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AOL-IP: 146.115.27.35
X-Mailer: Unknown (No Version)
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Says "no such file or directory" for ANY /dev/hd*.  And Mandrake's 
hardware detection doesn't show any other hard drive device other than 
the OS drive.


chaosite@gmail.com wrote:
> andyliebman@aol.com wrote:
>> I have an image of a working 2.6.14 system that was installed on an 
>> IDE drive. I restored the image to a SATA drive, changed a few lines 
>> in /etc/fstab and /etc/lilo.conf so that they refer to /dev/sd* 
>> devices instead of /dev/hd* devices.
> 
> If all your drives are S/ATA, your CDROM should be the only /dev/hd? 
> device.
> 
> if you try 'ls /dev/hd?', doesn't it show anything?
> 


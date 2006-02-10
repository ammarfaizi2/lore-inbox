Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWBJQd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWBJQd7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 11:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWBJQd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 11:33:58 -0500
Received: from 8.ctyme.com ([69.50.231.8]:16296 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S1751295AbWBJQdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 11:33:35 -0500
Message-ID: <43ECC05D.6010901@perkel.com>
Date: Fri, 10 Feb 2006 08:33:33 -0800
From: Marc Perkel <marc@perkel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Prakash Punnoor <prakash@punnoor.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: ata1: command 0x35 timeout sata_nv driver
References: <43ECB9EA.9000804@perkel.com> <200602101730.47512.prakash@punnoor.de>
In-Reply-To: <200602101730.47512.prakash@punnoor.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Prakash Punnoor wrote:
> Am Freitag Februar 10 2006 17:06 schrieb Marc Perkel:
>   
>> Are there still problems with sata_nv?
>>
>> Running 2 maxtor 250gig drives with 16mb buffer.
>>
>> Getting this error:
>> ata1: command 0x35 timeout, stat 0x50 hos_stat 0x24
>> ata2: command 0x35 timeout, stat 0x50 hos_stat 0x24
>>     
>
> Maxtor released a new BIOS fixing issues with nforce4. Maybe you want to ask 
> bios for the fw and test it?
>
>   
So I update the drive bios? Where do I find that? Thanks for your help.


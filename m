Return-Path: <linux-kernel-owner+w=401wt.eu-S965220AbXAJWvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965220AbXAJWvn (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 17:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965172AbXAJWvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 17:51:43 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:44819 "EHLO
	pd2mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965220AbXAJWvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 17:51:42 -0500
Date: Wed, 10 Jan 2007 16:50:31 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: SATA/IDE Dual Mode w/Intel 945 Chipset or HOW TO LIQUIFY a flash
 IDE chip under 2.6.18
In-reply-to: <fa.knaXdjvwhsPCFpF5idaEG5sHhcM@ifi.uio.no>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <45A56DB7.6050901@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.w2Xz1pEig0R6ShqpHFJyconmPBo@ifi.uio.no>
 <fa.Dlil7VK33821i8DmcFWlIN2XaQU@ifi.uio.no>
 <fa.tj/VxhLXoYhj9fN5JWFl+JK12nU@ifi.uio.no>
 <fa.j4A1taZJ5T85q4EnugrwsVjbq80@ifi.uio.no>
 <fa.F7iasR6Lz0YMnhzBecxJ2HmeL/Y@ifi.uio.no>
 <fa.knaXdjvwhsPCFpF5idaEG5sHhcM@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:
> On Wed, Jan 10, 2007 at 09:58:21AM -0500, Jeff Garzik wrote:
>> Enhanced mode means separate SATA and PATA.
>>
>> (I recommend avoiding the "IDE" acronym, it is largely meaningless and 
>> confusing these days)
> 
> Good idea.
> 
>> We're talking about Linux here.  Linux regularly supports hardware 
>> before Windows does.  This is nothing new.
> 
> That is certainly true.  I just found it odd that intel wouldn't have an
> ahci driver available.  But then again if ahci is standard I guess they
> would expect microsoft to provide the driver instead, which they
> probably aren't doing until vista.  Linux always seems so much easier.
> :)  The drivers are just included for everything.

There are AHCI drivers available for Windows for sure. Think it's part 
of the "Intel Application Accelerator" package or something.

Think there was talk that Microsoft would write a standard AHCI driver, 
but right now all the vendors are writing their own I believe.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


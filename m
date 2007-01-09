Return-Path: <linux-kernel-owner+w=401wt.eu-S932560AbXAJAAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbXAJAAe (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 19:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbXAJAAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 19:00:34 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:51532 "EHLO
	rwcrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932501AbXAJAAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 19:00:33 -0500
Message-ID: <45A426C3.8070208@wolfmountaingroup.com>
Date: Tue, 09 Jan 2007 16:35:31 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921 Red Hat/1.7.12-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: SATA/IDE Dual Mode w/Intel 945 Chipset or HOW TO LIQUIFY a flash
 IDE chip under 2.6.18
References: <45A3FF32.1030905@wolfmountaingroup.com> <20070109225940.GG17269@csclub.uwaterloo.ca>
In-Reply-To: <20070109225940.GG17269@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:

>On Tue, Jan 09, 2007 at 01:46:42PM -0700, Jeff V. Merkey wrote:
>  
>
>>I just finished pulling out a melted IDE flash drive out of a Shuttle 
>>motherboard with the intel 945 chipset which claims to support
>>SATA and IDE drives concurrently under Linux 2.6.18.
>>
>>The chip worked for about 30 seconds before liquifying in the chassis.  
>>I note that the 945 chipset in the shuttle PC had some serious
>>issues recognizing 2 x SATA devices and a IDE device concurrently.   Are 
>>there known problems with the Linux drivers
>>with these newer chipsets.
>>    
>>
>
>Had the drive ever been used in any other machine?  
>

Yes, on a SuperMicro X6DHE-G2 Xeon motherboard -- worked fine.

>Had any ide device
>ever been used in this machine before?  
>
Yes. external cabled CDROM Drive seems to work.

Jeff

>It really sounds like a hardware
>problem, since I can't think of anything software could do to make that
>kind of current go through the flash drive.
>
>I remember seeing the controller chip on a 730MB quantum scsi drive
>start to glow red many years ago, just before the drive stopped
>responding to the system (and I turned off the power).  Hardware does
>fail.  It almost never has anything to do with software.
>
>--
>Len Sorensen
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263382AbTCNQBl>; Fri, 14 Mar 2003 11:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263383AbTCNQBl>; Fri, 14 Mar 2003 11:01:41 -0500
Received: from adsl-67-113-154-34.dsl.sntc01.pacbell.net ([67.113.154.34]:46583
	"EHLO postbox.aslab.com") by vger.kernel.org with ESMTP
	id <S263382AbTCNQBi>; Fri, 14 Mar 2003 11:01:38 -0500
Message-ID: <3E7200D1.3030207@aslab.com>
Date: Fri, 14 Mar 2003 08:18:25 -0800
From: Michael Madore <mmadore@aslab.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: Terry Barnaby <terry@beam.ltd.uk>, linux-kernel@vger.kernel.org
Subject: Re: Reproducible SCSI Error with Adaptec 7902
References: <3E71B629.60204@beam.ltd.uk> <1999490000.1047653585@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also, what version of firmware do your drives have?  Our original 
problems stemmed from buggy firmware.  Seagate have updated firmware 
which you can request from their technical support.

Mike

Justin T. Gibbs wrote:

>>Our system is:
>>System: Dual Xeon 2.4GHz system using SuperMicro X5DA8 Motherboard.
>>SCSI: Adaptec 7902 onboard dual channel SCSI controller
>>Disks: 2 off Quantum Atlas 10K2 18G (160LW), 1 of Quantum 9G (80LW)
>>Disks: 1 off Seagate ST336607LW 36G (320LW)
>>System: RedHat 7.3 with updates to 18/02/03
>>Kernel: 2.4.18-24.7.xsmp
>>Aic79xx Driver: versions 1.0.0 and 1.1.0
>>    
>>
>
>Is there some reason why you are using such old versions of the aic79xx
>driver?  You can obtain the latest version of the driver from here:
>
>http://people.FreeBSD.org/~gibbs/linux/RPM/aic79xx/
>http://people.FreeBSD.org/~gibbs/linux/DUD/aic79xx/
>
>or in source form for a 2.4.X or 2.5.X kernel from here:
>
>http://people.freebsd.org/~gibbs/linux/SRC/
>
>--
>Justin
>  
>




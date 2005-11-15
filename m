Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbVKOSBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbVKOSBF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 13:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbVKOSBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 13:01:05 -0500
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:38016 "EHLO
	vger.utah-nac.org") by vger.kernel.org with ESMTP id S964962AbVKOSBE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 13:01:04 -0500
Message-ID: <437A0E7E.2080209@wolfmountaingroup.com>
Date: Tue, 15 Nov 2005 09:36:14 -0700
From: "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Bernd Petrovitsch <bernd@firmix.at>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <58XuN-29u-17@gated-at.bofh.it> <58XuN-29u-19@gated-at.bofh.it>	 <58XuN-29u-21@gated-at.bofh.it> <58XuN-29u-23@gated-at.bofh.it>	 <58XuN-29u-25@gated-at.bofh.it> <58XuN-29u-15@gated-at.bofh.it>	 <58YAt-3Fs-5@gated-at.bofh.it> <58ZGo-5ba-13@gated-at.bofh.it>	 <5909m-5JB-5@gated-at.bofh.it> <43795F35.3050904@shaw.ca>	 <43795C55.9080305@wolfmountaingroup.com>  <43796489.8090500@shaw.ca>	 <1132047119.27192.14.camel@tara.firmix.at> <1132047951.2822.11.camel@laptopd505.fenrus.org>
In-Reply-To: <1132047951.2822.11.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>>And yes, you need ndiswrapper for almost all of the WLAN drivers since
>>there is no documentation of them.
>>    
>>
>
>you're wrong.
>
>
>documentation for broadcom wireless:
>http://bcm-specs.sipsolutions.net/
>embrionic driver based on this spec:
>http://bcm43xx.berlios.de/
>
>driver for atheros wireless is nearly done:
>http://www.selenic.com/pipermail/kernel-mentors/2005-August/000351.html
>
>
>now if people started to help these folks instead of crying for
>ndiswrapper binary solutions maybe those drivers will be finished
>quicker.
>  
>

No one is crying about ndiswrapper, some folks just want to use Linux on 
their laptops without waiting
two years for all the drivers to port to Linux.  Make the 4K stack 
setting a command line option.   Problem solved.

Jeff

>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


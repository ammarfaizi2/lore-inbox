Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262437AbVCIV3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbVCIV3X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 16:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbVCIV0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 16:26:12 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:2463 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262441AbVCIUdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 15:33:42 -0500
Message-ID: <422F5DA4.60807@us.ltcfwd.linux.ibm.com>
Date: Wed, 09 Mar 2005 15:33:40 -0500
From: Wen Xiong <wendyx@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: "Kilau, Scott" <Scott_Kilau@digi.com>, Wen Xiong <wendyx@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [ patch 6/7] drivers/serial/jsm: new serial device driver
References: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D9EB@minimail.digi.com> <20050309195110.GA28312@kroah.com>
In-Reply-To: <20050309195110.GA28312@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Wed, Mar 09, 2005 at 01:35:41PM -0600, Kilau, Scott wrote:
>  
>
>>As it stands today, your requirement appears to be that she needs
>>to yank all diags ioctls and sysfs files before the driver can make
>>it into the kernel sources.
>>    
>>
>
>Not all sysfs files, sysfs files are fine, as long as they are
>implemented properly, and are there for things that "make sense".
>
>But yes, it should would be easier to accept the driver if the ioctls
>were not there :)
>
>thanks,
>
>greg k-h
>
>  
>
Hi All,

I think Digi's DPA magagement tool has very good user interfaces. I am 
going to change and fix the problem.
Then Greg can decide if he want to pick it up or not.

I will attatch the DPA graphic interface for you next time.

Thanks,
wendy


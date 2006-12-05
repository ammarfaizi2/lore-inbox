Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968508AbWLERqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968508AbWLERqc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 12:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968519AbWLERqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 12:46:31 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:59853 "EHLO
	rwcrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968508AbWLERqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 12:46:31 -0500
Message-ID: <4575AC4B.4060008@wolfmountaingroup.com>
Date: Tue, 05 Dec 2006 10:28:43 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921 Red Hat/1.7.12-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vladislav Bolkhovitin <vst@vlnb.net>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: scst support for kernels above 2.6.15
References: <4574ABB1.8000301@wolfmountaingroup.com> <45754E27.9020609@vlnb.net>
In-Reply-To: <45754E27.9020609@vlnb.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladislav Bolkhovitin wrote:

>Jeff V. Merkey wrote:
>  
>
>>I have noticed that scsi_do_req has apparently been obsoleted in 2.6.18 
>>and above.  Is scst and target support for FC-AL going to
>>remain supported and/or merged at some point?   If so, what is planned 
>>for scst support for later kernels?
>>    
>>
>
>Jeff, I don't know why you ask here and not in scst-devel mailing list,
>but SCST has beed updated to use scsi_execute_async() instead of
>scsi_do_req() in 2.6.18+ for quite a while. Yes, scst is going to be
>supported in the future.
>
>Vlad
>  
>
The code is not at sourceforge on your project site with these updates 
for 2.6.18. Where is the 2.6.18 version currently hosted?

P.S. I will post this to the scsi list in the future.

Thanks

Jeff

>  
>
>>Jeff
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>>    
>>
>
>
>  
>


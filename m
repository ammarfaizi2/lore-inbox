Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265868AbTFSRss (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 13:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265869AbTFSRsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 13:48:47 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:19143 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S265868AbTFSRsq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 13:48:46 -0400
Message-ID: <3EF1FB28.4050608@austin.ibm.com>
Date: Thu, 19 Jun 2003 13:04:24 -0500
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ext3 umount hangs
References: <3EF1EC73.4070305@austin.ibm.com> <20030619105817.51613df2.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Steven Pratt <slpratt@austin.ibm.com> wrote:
>  
>
>>Has anyone else seen hangs trying to umount ext3 volumes?
>>    
>>
>
>Nope.
>
>> I am seeing 
>>this repeatedly after running tiobench on an ext3 volume.  This was only 
>>showing up in the mm tree, but as of 2.5.72-bk2 I am now seeing it in 
>>the mainline.
>>    
>>
>
>It would have been nice to have heard about it before this...
>  
>
Sorry, lots of thing on my plate.

>Could you please debug it a bit?  sysrq-T, etc?
>
Yes, I will try to get this as soon as possible.

>Does the system hang, or does the umount hang?
>
Just the umount hangs, but it is severe enough to not be able to 
shutdown the system.  Have to power off.

Steve

>  
>



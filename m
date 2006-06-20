Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965055AbWFTFw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbWFTFw2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 01:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbWFTFw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 01:52:28 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:4240 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965055AbWFTFw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 01:52:27 -0400
Message-ID: <44978D20.5080403@cn.ibm.com>
Date: Tue, 20 Jun 2006 13:52:32 +0800
From: Yao Fei Zhu <walkinair@cn.ibm.com>
Reply-To: walktodeath@163.com
Organization: IBM
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to get kernel source release from git tree?
References: <4497830B.5010402@163.com> <e780d2$br9$1@terminus.zytor.com>
In-Reply-To: <e780d2$br9$1@terminus.zytor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

>Followup to:  <4497830B.5010402@163.com>
>By author:    Walkinair <walktodeath@163.com>
>In newsgroup: linux.dev.kernel
>  
>
>>Hi, this may be a stupid question, sorry for this.
>>
>>I have kenel 2.6 git tree in my local box, usually through the following 
>>steps I get source release,
>>1. copy git repository to a new directory.
>>2. rm .git directory.
>>3. make config; make; make modules_install; make install
>>
>>I there any convinient git command or other ways to get kernel release 
>>from git repository?
>>
>>    
>>
>
>If you have Cogito installed, use cg-export.
>
>	-hpa
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Thank you, cg-export works.


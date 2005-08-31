Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbVIAAFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbVIAAFU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 20:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbVIAAFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 20:05:20 -0400
Received: from [67.137.28.189] ([67.137.28.189]:65459 "EHLO vger")
	by vger.kernel.org with ESMTP id S964994AbVIAAFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 20:05:20 -0400
Message-ID: <43163430.7010107@utah-nac.org>
Date: Wed, 31 Aug 2005 16:50:24 -0600
From: jmerkey <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Diego Calleja <diegocg@gmail.com>
Cc: "Jeff V. Merkey" <jmerkey@soleranetworks.com>, Valdis.Kletnieks@vt.edu,
       arjan@infradead.org, riel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] DSFS Network Forensic File System for Linux Patches
References: <4315DBE7.7080002@soleranetworks.com>	<Pine.LNX.4.63.0508311432270.16968@cuia.boston.redhat.com>	<4315E88D.9020603@soleranetworks.com>	<1125514716.3213.24.camel@laptopd505.fenrus.org>	<4315F04D.5050705@soleranetworks.com>	<200508312128.j7VLST47010653@turing-police.cc.vt.edu>	<431611B7.6000103@soleranetworks.com>	<431612C3.7020903@soleranetworks.com> <20050901012218.02c79560.diegocg@gmail.com>
In-Reply-To: <20050901012218.02c79560.diegocg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja wrote:

>El Wed, 31 Aug 2005 14:27:47 -0600,
>"Jeff V. Merkey" <jmerkey@soleranetworks.com> escribió:
>
>  
>
>> 
>>NOTE! This copyright does *not* cover user programs that use kernel
>> services by normal system calls - this is merely considered normal use
>> of the kernel, and does *not* fall under the heading of "derived work".
>> Also note that the GPL below is copyrighted by the Free Software
>> Foundation, but the instance of code that it refers to (the linux
>> kernel) is copyrighted by me and others who actually wrote it.
>>    
>>
>
>So, that means that DSFS runs on userspace? (We can't see the source
>so it'd be nice to know how DSFS works)
>
>Also, I'm curious about this piece of code on your patch:
>ftp://ftp.soleranetworks.com/pub/dsfs/datascout-only-2.6.9-06-28-05.patch
>
>-		printk(KERN_WARNING "%s: module license '%s' taints kernel.\n",
>-		       mod->name, license);
>+//		printk(KERN_WARNING "%s: module license '%s' taints kernel.\n",
>+//		       mod->name, license);
>
>I mean, nvidia people also use propietary code in the kernel (probably
>violating the GPL anyway) and don't do such things.
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
I disagree with the language and the characterization that our 
proprietary user application code is "tainted."

Jeff

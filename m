Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030344AbWBVXW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbWBVXW7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 18:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbWBVXW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 18:22:59 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:29838 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S1030344AbWBVXW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 18:22:58 -0500
Message-ID: <43FCFF82.70401@soleranetworks.com>
Date: Wed, 22 Feb 2006 17:19:14 -0700
From: "Jeff V. Merkey" <jmerkey@soleranetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joel Jaeggli <joelja@darkwing.uoregon.edu>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Red Hat ES4 GPL Issues?
References: <43FCFDC6.9090109@soleranetworks.com> <Pine.LNX.4.64.0602221519540.5009@twin.uoregon.edu>
In-Reply-To: <Pine.LNX.4.64.0602221519540.5009@twin.uoregon.edu>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Jaeggli wrote:

That's the one. Thanks. I looked all over the place and could not find 
it. I am concerned they are not shipping the Source Code with the Distro,
which is what they normally do.

Jeff

> On Wed, 22 Feb 2006, Jeff V. Merkey wrote:
>
>>
>> I have been working on 2.6.9 kernels with red hat ES4 series 
>> distributions (we purchased and have a license). I noticed that the 
>> ES4 series kernels
>> which support NPTL libs no longer provide the source code with the 
>> distribution (the installed kernels sources point to empty source 
>> trees which
>> only contain makefiles). I have discovered we have to use our Red Hat 
>> Network account in order to download the Source RPMs
>> (which are in fact provided).
>>
>> We got the distro via electronic fullfilment, so we did not get the 
>> SRPMS CD iso images by default. This was a deviation from how Red Hat
>> normally distributes source code with their Linux distro.
>>
>> I am curious if Red Hat views requiring people subscribing to RHN as 
>> a requirement to obtain source code is in conflict with the GPL. We
>> have no objection to downloading it since we have an account, but I 
>> found it strange Red Hat, the leaders in Open Source and GPL
>> technology, now appear to block downloads of ES4 source code without 
>> a subscription. Have I got it all wrong here, or is this borderline GPL
>> avoidance?
>>
>> I am unable to locate the Source Code on any public servers at Red Hat.
>
>
> is this the one you're looking for:
>
> ftp://ftp.redhat.com/pub/redhat/linux/enterprise/4/en/os/i386/SRPMS/kernel-2.6.9-5.EL.src.rpm 
>
>
> ftp://ftp.redhat.com/pub/redhat/linux/updates/enterprise/4WS/en/os/SRPMS/kernel-2.6.9-22.0.2.EL.src.rpm 
>
>
>> Jeff
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at http://www.tux.org/lkml/
>>
>


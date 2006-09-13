Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWIMQdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWIMQdm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 12:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750700AbWIMQdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 12:33:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:30353 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1750702AbWIMQdk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 12:33:40 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,160,1157353200"; 
   d="scan'208"; a="129807277:sNHT1893644970"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: speedstep-centrino broke
Date: Wed, 13 Sep 2006 09:33:25 -0700
Message-ID: <EB12A50964762B4D8111D55B764A84549560BA@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: speedstep-centrino broke
Thread-Index: AcbXBi37R5pw1sZKQEOH6gtxDPzxXAAS+ssg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Michiel de Boer" <x@rebelhomicide.demon.nl>,
       "Ben B" <kernel@bb.cactii.net>
Cc: <linux-kernel@vger.kernel.org>, <davej@codemonkey.org.uk>
X-OriginalArrivalTime: 13 Sep 2006 16:33:26.0386 (UTC) FILETIME=[566C3520:01C6D752]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
>Michiel de Boer
>Sent: Wednesday, September 13, 2006 12:28 AM
>To: Ben B
>Cc: linux-kernel@vger.kernel.org; davej@codemonkey.org.uk
>Subject: Re: speedstep-centrino broke
>
>Ben B wrote:
>> Hi,
>>
>> My HP notebook decided that its BIOS upgrade would break
>> speedstep-centrino, and trying to load the module gives me a "no such
>> device" error. This is with various combinations of kernel config
>> relating to cpufreq. Also tried acpi-cpufreq with the same error.
>>
>> I suspect that the new bios is broken, but perhaps it's 
>correct and the
>> linux driver is missing something?
>>
>> Anyway, relevent info below.
>>
>> Cheers,
>> Ben
>>   
>
>I have the same problem, running kernel 2.6.17.13, and also 
>get the 'No 
>such device' error.
>This problem doesn't occur when i boot 2.6.16.16, so the 
>behaviour must 
>have been introduced
>somewhere in between.
>

Just to confirm. Moving from 2.6.16.16 to 2.6.17.13 with no other change
to system (BIOS change) breaks the driver? Did you also try acpi-cpufreq
driver with 2.6.17.13?

Thanks,
Venki

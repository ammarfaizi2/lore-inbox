Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755828AbWKQXsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755828AbWKQXsd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 18:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756040AbWKQXsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 18:48:33 -0500
Received: from nz-out-0102.google.com ([64.233.162.200]:53852 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1755828AbWKQXsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 18:48:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RBl5zT2H7j4lg81SDFC73fJljALTnhLSc5leNfZKyYJfPwO3aGQQ4xLDrqQdfMa9mjcSgrGdPeZTKjmF6MbRxTq+Wa5xiC93Ya0VVH1TkRnAI7GiZZssugpkPbLoLFwSAvlHKVUkOpg6j2Vyy1IVFyyfanKqf0nfgiDGtIBTSro=
Message-ID: <8aa016e10611171548k493f8416k905a4a8f42320699@mail.gmail.com>
Date: Sat, 18 Nov 2006 05:18:32 +0530
From: "Dhaval Giani" <dhaval.giani@gmail.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [BUG][acpi-cpufreq/userspace-governor]Frequency does not change
Cc: davej@codemonkey.org.uk,
       "Diefenbaugh, Paul S" <paul.s.diefenbaugh@intel.com>, linux@brodo.de,
       "Sadykov, Denis M" <denis.m.sadykov@intel.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <EB12A50964762B4D8111D55B764A8454E76579@scsmsx413.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <EB12A50964762B4D8111D55B764A8454E76579@scsmsx413.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On 11/18/06, Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com> wrote:
>
>
>
> >-----Original Message-----
> >From: Dhaval Giani [mailto:dhaval.giani@gmail.com]
> >Sent: Friday, November 17, 2006 1:22 PM
> >To: Pallipadi, Venkatesh; davej@codemonkey.org.uk;
> >Diefenbaugh, Paul S; linux@brodo.de; Sadykov, Denis M
> >Cc: linux-kernel@vger.kernel.org
> >Subject: [BUG][acpi-cpufreq/userspace-governor]Frequency does
> >not change
> >
> >Hey there,
> >
> >Looks like I spoke too soon. I tried changing the frequency in cpu1
> >and then it all fell apart. I got a ridiculously high value. To test
> >it, I rebooted my system, and this is what happened.
> >
>
> You will also need another patch here.
> http://lists.linux.org.uk/mailman/private/cpufreq/2006-November/006591.h
> tml
>
> Please apply that patch along with the other one that you already
> applied and let me know if you still see the issue.
>

Applied, still having the oops.

> Thanks,
> Venki
>

Thanks
Dhaval

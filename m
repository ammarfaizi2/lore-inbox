Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030742AbWKOR17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030742AbWKOR17 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030745AbWKOR17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:27:59 -0500
Received: from wx-out-0506.google.com ([66.249.82.239]:4501 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030744AbWKOR16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:27:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VOyjl7w26P//uELoVXEc/jLUH8cG3v07bCUlg0dcQhqV9aiAy1Fej6j/2U89LbYMnigladWWEie/06sUEiQHg2MaTT6m/wuWNXI3rwdrn6rtvGxtVGqepfgALJBUIP1OTYnBmCXvpHjUhgwFgqsmO2650wPQa+hPD8ZCGEuitbU=
Message-ID: <8aa016e10611150927p581a3290ne8b46d5fa034799d@mail.gmail.com>
Date: Wed, 15 Nov 2006 22:57:56 +0530
From: "Dhaval Giani" <dhaval.giani@gmail.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: CPUFREQ does not get enabled
Cc: davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <EB12A50964762B4D8111D55B764A8454E411EA@scsmsx413.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <EB12A50964762B4D8111D55B764A8454E411EA@scsmsx413.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey

On 11/15/06, Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com> wrote:
>
> Can you compile in this option
> # CONFIG_X86_SPEEDSTEP_CENTRINO is not set
> And try again.
>

Done and it still does not work. BTW, the help says that
X86_SPEEDSTEP_CENTRINO is deprecated and to use X86_ACPI_CPUFREQ which
is why I did not enable it.

> Thanks,
> Venki
>
>
Thanks
Dhaval

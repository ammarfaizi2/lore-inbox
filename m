Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291193AbSBGSZI>; Thu, 7 Feb 2002 13:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291194AbSBGSYv>; Thu, 7 Feb 2002 13:24:51 -0500
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:5900 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S291198AbSBGSYf>;
	Thu, 7 Feb 2002 13:24:35 -0500
Subject: Re: Intel Speedstep bug in 2.4.17?
From: Shaya Potter <spotter@cs.columbia.edu>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1020206112505.7298E-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1020206112505.7298E-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 07 Feb 2002 13:24:10 -0500
Message-Id: <1013106251.18673.292.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

didn't change a thing on my t21

On Wed, 2002-02-06 at 11:26, Bill Davidsen wrote:
> On 5 Feb 2002, Doug Alcorn wrote:
> 
> > Here are my APM configuration variables for my kernel:
> > 
> > CONFIG_APM=y
> > # CONFIG_APM_IGNORE_USER_SUSPEND is not set
> > # CONFIG_APM_DO_ENABLE is not set
> > CONFIG_APM_CPU_IDLE=y
> > CONFIG_APM_DISPLAY_BLANK=y
> > CONFIG_APM_RTC_IS_GMT=y
> > CONFIG_APM_ALLOW_INTS=y
> > # CONFIG_APM_REAL_MODE_POWER_OFF is not set
> > # CONFIG_ACPI is not set
> 
>   I think the the CPU_IDLE is the problem.
> 
> -- 
> bill davidsen <davidsen@tmr.com>
>   CTO, TMR Associates, Inc
> Doing interesting things with little computers since 1979.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



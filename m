Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289240AbSBFQ1a>; Wed, 6 Feb 2002 11:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290643AbSBFQ1T>; Wed, 6 Feb 2002 11:27:19 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:64004 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S289240AbSBFQ1H>; Wed, 6 Feb 2002 11:27:07 -0500
Date: Wed, 6 Feb 2002 11:26:17 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Doug Alcorn <lathi@seapine.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Intel Speedstep bug in 2.4.17?
In-Reply-To: <87eljzb8l6.fsf@localhost.localdomain>
Message-ID: <Pine.LNX.3.96.1020206112505.7298E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Feb 2002, Doug Alcorn wrote:

> Here are my APM configuration variables for my kernel:
> 
> CONFIG_APM=y
> # CONFIG_APM_IGNORE_USER_SUSPEND is not set
> # CONFIG_APM_DO_ENABLE is not set
> CONFIG_APM_CPU_IDLE=y
> CONFIG_APM_DISPLAY_BLANK=y
> CONFIG_APM_RTC_IS_GMT=y
> CONFIG_APM_ALLOW_INTS=y
> # CONFIG_APM_REAL_MODE_POWER_OFF is not set
> # CONFIG_ACPI is not set

  I think the the CPU_IDLE is the problem.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


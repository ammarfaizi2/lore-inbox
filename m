Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292402AbSBPQP0>; Sat, 16 Feb 2002 11:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292403AbSBPQPQ>; Sat, 16 Feb 2002 11:15:16 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:58374 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S292402AbSBPQPF>;
	Sat, 16 Feb 2002 11:15:05 -0500
Date: Sat, 16 Feb 2002 09:14:05 -0700
From: yodaiken@fsmlabs.com
To: george anzinger <george@mvista.com>
Cc: Tyson D Sawyer <tyson@rwii.com>, linux-kernel@vger.kernel.org
Subject: Re: Missed jiffies
Message-ID: <20020216091405.D29832@hq.fsmlabs.com>
In-Reply-To: <3C6E77DE.70FE49DF@rwii.com> <3C6E833F.1A888B3C@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3C6E833F.1A888B3C@mvista.com>; from george@mvista.com on Sat, Feb 16, 2002 at 08:05:19AM -0800
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2002 at 08:05:19AM -0800, george anzinger wrote:
> I think the real problem needs to be addressed, i.e. why does the SMI
> (and/ or other code) keep the interrupt system off so long.  Most
> interrupts are completed in micro seconds, not milliseconds, lets fix
> the real problem.

The SMI is an unbearable abomination and it is an issue that even Microsoft
has been unable to make Intel respond to properly. It makes Rambus seem brilliant.
The basic idea: take a high speed well optimized processor that is the most
critical performance component of your system and arbitrarily divert it to managing
fans completely outside of OS control is so unbearably stupid, arrogant, ugly and 
nauseating as to be hard to believe even in this industry.


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com


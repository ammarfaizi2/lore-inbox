Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291876AbSBHWN2>; Fri, 8 Feb 2002 17:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291878AbSBHWNS>; Fri, 8 Feb 2002 17:13:18 -0500
Received: from dialin-145-254-136-157.arcor-ip.net ([145.254.136.157]:3076
	"EHLO dale.home") by vger.kernel.org with ESMTP id <S291876AbSBHWNI>;
	Fri, 8 Feb 2002 17:13:08 -0500
Date: Fri, 8 Feb 2002 23:13:05 +0100
From: Alex Riesen <fork0@users.sourceforge.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18-pre8-K2: Kernel panic: CPU context corrupt
Message-ID: <20020208231305.B13545@steel>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
In-Reply-To: <20020208001831.A200@steel> <20020208003653.A28235@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020208003653.A28235@suse.de>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 12:36:53AM +0100, Dave Jones wrote:
> On Fri, Feb 08, 2002 at 12:18:31AM +0100, Alex Riesen wrote:
>  
>  > Feb  7 23:45:31 steel kernel: CPU 0: Machine Check Exception: 0000000000000004
>  > Feb  7 23:45:31 steel kernel: Bank 4: b200000000040151
>  > Feb  7 23:45:31 steel kernel: Kernel panic: CPU context corrupt
> 
>  Machine checks are indicative of hardware fault.
>  Overclocking, inadequate cooling and bad memory are the usual causes.

no overclocking, memtest passed (1 pass, 1 hour), native intel cooler.
Space radiation, maybe 8)


>  > P.S. no nasty suspections about processor, please. No funds reserved
>  > for a new one :)
> 
>  The truth hurts 8(

oh dear...

> 
> -- 
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs

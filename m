Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135242AbREESct>; Sat, 5 May 2001 14:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135248AbREESci>; Sat, 5 May 2001 14:32:38 -0400
Received: from [24.93.67.54] ([24.93.67.54]:11279 "EHLO mail7.nc.rr.com")
	by vger.kernel.org with ESMTP id <S135242AbREEScV>;
	Sat, 5 May 2001 14:32:21 -0400
Subject: Re: Could clock granularity be increased????
From: Sam Coles <sam@bcinet.net>
To: shreenivasa H V <shreenihv@usa.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010505175314.7785.qmail@nwcst288.netaddress.usa.net>
In-Reply-To: <20010505175314.7785.qmail@nwcst288.netaddress.usa.net>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 05 May 2001 14:34:14 -0400
Message-Id: <989087664.885.0.camel@sam>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Will editing include/asm/param.h not do the trick?

Sam

On 05 May 2001 12:53:14 -0500, shreenivasa H V wrote:
> Hi,
> 
> Is there any way I could use a clock granularity of less than 10ms if I need
> to do some hacking of the kernel TCP code? Ideally I would require the
> interval of the order of 10-100 microseconds. 
> thanks,
> shreeni.
> 
> ____________________________________________________________________
> Get free email and a permanent address at http://www.netaddress.com/?N=1
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


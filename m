Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262515AbTCMULW>; Thu, 13 Mar 2003 15:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262517AbTCMULW>; Thu, 13 Mar 2003 15:11:22 -0500
Received: from air-2.osdl.org ([65.172.181.6]:11470 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262515AbTCMULU>;
	Thu, 13 Mar 2003 15:11:20 -0500
Date: Thu, 13 Mar 2003 12:21:59 -0800
From: Dave Olien <dmo@osdl.org>
To: Samium Gromoff <deepfire@ibe.miee.ru>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: DAC960 in 2.5.59 vs modem
Message-ID: <20030313202159.GA23107@osdl.org>
References: <20030313163926.6e95029f.deepfire@ibe.miee.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030313163926.6e95029f.deepfire@ibe.miee.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sam,

Hmmm...  You're not giving me a lot of information here.
What version Linux are you running?  Is this new behavior
since you upgraded to a new kernel version, or is this
an entirely new configuration?

What device are you running ppp over?

Do the DAC960 and your ppp device happen to share IRQ?

Dave Olien


On Thu, Mar 13, 2003 at 04:39:26PM +0300, Samium Gromoff wrote:
> 	The matters are quite simple: any disk acces to the drives on my
>   DAC960PL tends to kill my ppp connection. that is on a p3-600.
> 
> regards, Samium Gromoff
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

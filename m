Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263324AbTCNN2n>; Fri, 14 Mar 2003 08:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263325AbTCNN2n>; Fri, 14 Mar 2003 08:28:43 -0500
Received: from [213.171.53.133] ([213.171.53.133]:51725 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id <S263324AbTCNN2m>;
	Fri, 14 Mar 2003 08:28:42 -0500
Date: Fri, 14 Mar 2003 16:38:55 +0300
From: Samium Gromoff <deepfire@ibe.miee.ru>
To: Dave Olien <dmo@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: DAC960 in 2.5.59 vs modem
Message-Id: <20030314163855.220ef09b.deepfire@ibe.miee.ru>
In-Reply-To: <20030313202159.GA23107@osdl.org>
References: <20030313163926.6e95029f.deepfire@ibe.miee.ru>
	<20030313202159.GA23107@osdl.org>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Mar 2003 12:21:59 -0800
Dave Olien <dmo@osdl.org> wrote:

> 
> Sam,
> 
> Hmmm...  You're not giving me a lot of information here.
> What version Linux are you running?  Is this new behavior
2.5.59 as stated in the subject, however 2.4.19-pre9 suffers as well

> since you upgraded to a new kernel version, or is this
> an entirely new configuration?
> 
> What device are you running ppp over?
plain courier v.everything, speed is usually around 21600

> 
> Do the DAC960 and your ppp device happen to share IRQ?
no

> 
> Dave Olien
> 
> 
> On Thu, Mar 13, 2003 at 04:39:26PM +0300, Samium Gromoff wrote:
> > 	The matters are quite simple: any disk acces to the drives on my
> >   DAC960PL tends to kill my ppp connection. that is on a p3-600.
> > 
> > regards, Samium Gromoff
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 

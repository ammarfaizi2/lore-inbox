Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318451AbSGSEjR>; Fri, 19 Jul 2002 00:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318457AbSGSEjR>; Fri, 19 Jul 2002 00:39:17 -0400
Received: from ip68-100-183-147.nv.nv.cox.net ([68.100.183.147]:19858 "HELO
	ascellatech.com") by vger.kernel.org with SMTP id <S318451AbSGSEjQ>;
	Fri, 19 Jul 2002 00:39:16 -0400
Subject: Re: SMP Problem with 2.4.19-rc2 on Asus A7M266-D
From: Amith Varghese <amith@xalan.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <5.1.1.6.0.20020719121809.01d15d88@pop.cs.curtin.edu.au>
References: <5.1.1.6.0.20020719121809.01d15d88@pop.cs.curtin.edu.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 19 Jul 2002 00:42:10 -0400
Message-Id: <1027053730.3621.187.camel@viper>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the same setup with the same exact problem.

Amith

On Fri, 2002-07-19 at 00:26, David Shirley wrote:
> Hi Guys,
> 
> I was running 2.4.18 with an Asus A7M266-D Board with Athlon 2000 MP's fine,
> I decided to try out 2.4.19-rc2-ac2 and now the machine doesn't even boot.
> 
> With no kernel options (in grub) it gets upto "ENABLING IO-APIC IRQ's" and 
> a little
> bit further then it hangs and prints out "APIC error on CPU0: 00(08)"
> 
> If i put in noapic in grub it does exactly the same thing but prints out 
> the above lots and
> lots in quick succession and with CPU1 not 0.
> 
> Btw: It does the same thing with MPS1.4 rather than 1.1
> 
> Anyone?
> 
> Cheers
> Dave
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



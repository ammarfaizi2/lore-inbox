Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317834AbSGPXDd>; Tue, 16 Jul 2002 19:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317864AbSGPXDc>; Tue, 16 Jul 2002 19:03:32 -0400
Received: from employees.nextframe.net ([212.169.100.200]:11001 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S317834AbSGPXDc>; Tue, 16 Jul 2002 19:03:32 -0400
Date: Wed, 17 Jul 2002 01:17:00 +0200
From: Morten Helgesen <morten.helgesen@nextframe.net>
To: sanket rathi <sanket@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Aiie, killing the interrupt handler
Message-ID: <20020717011700.G103@sexything>
Reply-To: morten.helgesen@nextframe.net
References: <20020716145534.27565.qmail@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020716145534.27565.qmail@linuxmail.org>
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, 

On Tue, Jul 16, 2002 at 10:55:34PM +0800, sanket rathi wrote:
> I am getting this message "Aiie, killing the interrupt handler" and much more stuff dump on screen after that 
> system get hang and i have to reboot the system. what does it mean is there some problem in my driver's interrupt 
> routine i m working on linux 2.2.14-5 

2.2.14-5 ? you probably want to be working on something newer.

for anyone to even have a chance at figuring out what`s going on with your system, you`ll have
to run the, quote : "'Aiie, killing the interrupt handler' and much more stuff" (aka a kernel oops message), 
through ksymoops and show us the result. have a look at Documentation/oops-tracing.txt or the ksymoops 
documentation for more information.

> 
> Thanks in Advance
> 
> Sanket
> 
> 
> -- 
> Get your free email from www.linuxmail.org 
> 
> 
> Powered by Outblaze
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net

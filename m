Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277639AbRJLML4>; Fri, 12 Oct 2001 08:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277644AbRJLMLr>; Fri, 12 Oct 2001 08:11:47 -0400
Received: from [213.96.124.18] ([213.96.124.18]:10734 "HELO dardhal")
	by vger.kernel.org with SMTP id <S277639AbRJLMLe>;
	Fri, 12 Oct 2001 08:11:34 -0400
Date: Fri, 12 Oct 2001 14:14:49 +0000
From: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jdomingo@internautas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.11 & 2.4.12 are much slower
Message-ID: <20011012141449.A6168@dardhal.mired.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200110121206.f9CC6XV01124@spnew.snpe.co.yu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200110121206.f9CC6XV01124@spnew.snpe.co.yu>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 12 October 2001, at 14:06:32 +0200,
snpe wrote:

> Hello,
> 	I try kernel 2.4.11 and 2.4.12 (RH 7.1, gcc-2.96-81, celeron 300 mhz
> 256 mb ram, ide ata 100 ibm)
> 	I compile kernel with 2.4.11 - 110 minutes (with any other 40 min)
> KDE 2.2.1 is unresponsible and I back in 2.4.10
> 
Don't know about the problem you seem to experience. But it seems your
machine is completely broken both with 2.4.10 and 2.4.1[12]. A kernel
compile on such hardware that lasts 40 minutes is absolutely unusual.

My PC is a 166 Pentium (even no MMX), 64 MB RAM, and a hard disk that
bonnie reports having a maximun R/W performance of only 4 MB/s. With this
hardware, and kernel 2.4.11, a compilation of kernel 2.4.12 + some 
modules (100 in total), also running icewm, X 4.1, Mozilla, Xchat,
gkrellm, xawtv, several rxvt's and more, total compilation time for kernel
+ modules (make dep clean bzImage modules) is 65 minutes. And, in the
middle of the compilation, cron.daily was run.

So maybe there is a problem with kernel 2.4.1[12] on your setup, but it
seems that also your base hardware is not working as it should.

Greetings.

-- 
José Luis Domingo López
Linux Registered User #189436     Debian Linux Woody (P166 64 MB RAM)
 
jdomingo EN internautas PUNTO org  => ¿ Spam ? Atente a las consecuencias
jdomingo AT internautas DOT   org  => Spam at your own risk


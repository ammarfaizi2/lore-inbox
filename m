Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291621AbSBHPwn>; Fri, 8 Feb 2002 10:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291623AbSBHPwe>; Fri, 8 Feb 2002 10:52:34 -0500
Received: from mail2.panix.com ([166.84.0.213]:32745 "HELO mail2.panix.com")
	by vger.kernel.org with SMTP id <S291621AbSBHPw0>;
	Fri, 8 Feb 2002 10:52:26 -0500
Date: Sat, 9 Feb 2002 00:49:46 +0900
From: Jeff Lightfoot <jeffml@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18-pre9
Message-Id: <20020209004946.729052eb.jeffml@pobox.com>
In-Reply-To: <3C633608.2D0CDC51@mandrakesoft.com>
In-Reply-To: <Pine.LNX.4.21.0202071646550.17201-100000@freak.distro.conectiva>
	<002001c1b045$631ad760$030ba8c0@mistral>
	<3C633608.2D0CDC51@mandrakesoft.com>
X-Mailer: Sylpheed version 0.7.0claws52 (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Operating-System: Debian GNU/Linux 3.0;kernel 2.4.17
X-Face: 'u<#Qt^/)qW:&(>J[MA.~}578d+Wz3jc?f>yFwasPspU]Aq]z>~^7mt+~<Qi.>\+mlk.)8F LB,8#1B.a@vkU-P>GO7Jv'!a~5<!1TB{ba1P]/wSF+D2O.slxdmvp\6
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Feb 2002 21:20:56 -0500
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:

> > Can you tell me if the final 2.4.18 will solve the problems with
> > recent binutils?  Or is the onus on the binutils maintainer to fix
> > this?
> 
> What driver are you having problems with?

Hope this was an invitation for others also.

If more info is needed, let me know.

binutils: 2.11.92.0.12.3
kernel: 2.4.18-pre9

drivers/media/media.o: In function `bttv_probe':
drivers/media/media.o(.text.init+0x15cb): undefined reference to `local
symbols in discarded section .text.exit'


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286959AbSAIOwO>; Wed, 9 Jan 2002 09:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286962AbSAIOvy>; Wed, 9 Jan 2002 09:51:54 -0500
Received: from codepoet.org ([166.70.14.212]:12042 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S286959AbSAIOvm>;
	Wed, 9 Jan 2002 09:51:42 -0500
Date: Wed, 9 Jan 2002 07:51:26 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Felix von Leitner <felix-dietlibc@fefe.de>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] klibc requirements
Message-ID: <20020109145126.GA17918@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Felix von Leitner <felix-dietlibc@fefe.de>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020108192450.GA14734@kroah.com> <20020109042331.GB31644@codeblau.de> <20020109045109.GA17776@kroah.com> <20020109141514.GF2510@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020109141514.GF2510@codeblau.de>
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux 2.4.16-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Jan 09, 2002 at 03:15:14PM +0100, Felix von Leitner wrote:
> Thus spake Greg KH (greg@kroah.com):
> > > > 	- portable, runs on all platforms that the kernel currently
> > > > 	  works on, but doesn't have to run on any non-Linux based OS.
> > You didn't address this.  What are the future plans of porting dietLibc
> > to the platforms that are not currently supported by it (but are by
> > Linux)?
> 
> We will attempt to port the diet libc to every Linux platform that we
> have access to.  I won't go out and buy hardware to port my software to,
> so if anyone needs the diet libc ported somewhere, I need an account on
> a test box somewhere.
> 
> We are currently missing sh-linux, ia64-linux and m68k-linux and
> probably a few architectures that I have never heard of ;)

uClibc runs on both sh and ,68k, so the only arch missing 
coverage with either dietlibc or uClibc seems to be ia64.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

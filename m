Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286904AbSAIOb3>; Wed, 9 Jan 2002 09:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286758AbSAIObT>; Wed, 9 Jan 2002 09:31:19 -0500
Received: from junk.nocrew.org ([212.73.17.42]:29588 "EHLO junk.nocrew.org")
	by vger.kernel.org with ESMTP id <S286942AbSAIObE>;
	Wed, 9 Jan 2002 09:31:04 -0500
To: Felix von Leitner <felix-dietlibc@fefe.de>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] klibc requirements
In-Reply-To: <20020108192450.GA14734@kroah.com>
	<20020109042331.GB31644@codeblau.de>
	<20020109045109.GA17776@kroah.com> <20020109141514.GF2510@codeblau.de>
From: Lars Brinkhoff <lars.spam@nocrew.org>
Organization: nocrew
Date: 09 Jan 2002 15:30:54 +0100
In-Reply-To: <20020109141514.GF2510@codeblau.de>
Message-ID: <85bsg3zjdt.fsf@junk.nocrew.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix von Leitner <felix-dietlibc@fefe.de> writes:
> Thus spake Greg KH (greg@kroah.com):
> > > > 	- portable, runs on all platforms that the kernel currently
> > > > 	  works on, but doesn't have to run on any non-Linux based OS.
> > What are the future plans of porting dietLibc to the platforms
> > that are not currently supported by it (but are by Linux)?
> We will attempt to port the diet libc to every Linux platform that
> we have access to.  We are currently missing sh-linux, ia64-linux
> and m68k-linux and probably a few architectures that I have never
> heard of ;)

For the record: cris, parisc, s390, vax, x86-64.

-- 
Lars Brinkhoff          http://lars.nocrew.org/     Linux, GCC, PDP-10
Brinkhoff Consulting    http://www.brinkhoff.se/    programming

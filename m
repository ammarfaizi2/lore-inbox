Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286692AbSAIOPS>; Wed, 9 Jan 2002 09:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285828AbSAIOPI>; Wed, 9 Jan 2002 09:15:08 -0500
Received: from codeblau.walledcity.de ([212.84.209.34]:45071 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id <S286692AbSAIOPA>;
	Wed, 9 Jan 2002 09:15:00 -0500
Date: Wed, 9 Jan 2002 15:15:14 +0100
From: Felix von Leitner <felix-dietlibc@fefe.de>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] klibc requirements
Message-ID: <20020109141514.GF2510@codeblau.de>
In-Reply-To: <20020108192450.GA14734@kroah.com> <20020109042331.GB31644@codeblau.de> <20020109045109.GA17776@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020109045109.GA17776@kroah.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Greg KH (greg@kroah.com):
> > > 	- portable, runs on all platforms that the kernel currently
> > > 	  works on, but doesn't have to run on any non-Linux based OS.
> You didn't address this.  What are the future plans of porting dietLibc
> to the platforms that are not currently supported by it (but are by
> Linux)?

We will attempt to port the diet libc to every Linux platform that we
have access to.  I won't go out and buy hardware to port my software to,
so if anyone needs the diet libc ported somewhere, I need an account on
a test box somewhere.

We are currently missing sh-linux, ia64-linux and m68k-linux and
probably a few architectures that I have never heard of ;)

> It was sent and received on the dietlibc mailing list on Jan 04, 2001.
> It looks like the mailing list archive for the mailing list doesn't have
> any messages for Jan, 2001, otherwise I would point you at it.  I can
> forward it to you offline if you want me to.

Please do so!

Felix

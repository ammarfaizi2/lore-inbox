Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280159AbRJaL3K>; Wed, 31 Oct 2001 06:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280162AbRJaL3A>; Wed, 31 Oct 2001 06:29:00 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:39684 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S280159AbRJaL2u>; Wed, 31 Oct 2001 06:28:50 -0500
Date: Wed, 31 Oct 2001 07:42:59 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andrea@suse.de
Subject: Re: pre5 VM livelock
In-Reply-To: <Pine.LNX.4.33.0110301607220.1336-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0110310741420.4528-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Oct 2001, Linus Torvalds wrote:

> 
> On Tue, 30 Oct 2001, Jeff Garzik wrote:
> > Linus Torvalds wrote:
> > > Question: did you have some big process that you tried to test the VM
> > > with? Did you expect the oom killer to kill it?
> >
> > AFAICT, yes.  I am going to re-run again to make sure (both with pre5
> > and also pre5aa1).
> 
> Ok. The oom-killer is something I didn't even bother worrying about in the
> pre-series, I'll give that another look.

Jeff,

Could you please show us the _full_ Alt+Sysrq+M output when the problem
happens? I want to see the "free min low  high" part.

Thanks


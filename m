Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276709AbRJaAM0>; Tue, 30 Oct 2001 19:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275990AbRJaAMP>; Tue, 30 Oct 2001 19:12:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44561 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276709AbRJaAMG>; Tue, 30 Oct 2001 19:12:06 -0500
Date: Tue, 30 Oct 2001 16:10:03 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, <andrea@suse.de>
Subject: Re: pre5 VM livelock
In-Reply-To: <3BDF3B3D.3CAB3918@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0110301607220.1336-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 Oct 2001, Jeff Garzik wrote:
> Linus Torvalds wrote:
> > Question: did you have some big process that you tried to test the VM
> > with? Did you expect the oom killer to kill it?
>
> AFAICT, yes.  I am going to re-run again to make sure (both with pre5
> and also pre5aa1).

Ok. The oom-killer is something I didn't even bother worrying about in the
pre-series, I'll give that another look.

		Linus


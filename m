Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290022AbSAOQPm>; Tue, 15 Jan 2002 11:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290025AbSAOQPc>; Tue, 15 Jan 2002 11:15:32 -0500
Received: from [216.151.155.108] ([216.151.155.108]:44299 "EHLO
	varsoon.denali.to") by vger.kernel.org with ESMTP
	id <S290022AbSAOQP2>; Tue, 15 Jan 2002 11:15:28 -0500
To: David Lang <david.lang@digitalinsight.com>
Cc: Felix von Leitner <felix-dietlibc@fefe.de>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>, Greg KH <greg@kroah.com>,
        linux-kernel@vger.kernel.org, andersen@codepoet.org
Subject: Re: [RFC] klibc requirements
In-Reply-To: <Pine.LNX.4.40.0201150649430.23491-100000@dlang.diginsite.com>
From: Doug McNaught <doug@wireboard.com>
Date: 15 Jan 2002 11:15:18 -0500
In-Reply-To: David Lang's message of "Tue, 15 Jan 2002 06:54:46 -0800 (PST)"
Message-ID: <m3k7ujzj3d.fsf@varsoon.denali.to>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang <david.lang@digitalinsight.com> writes:

> as an example (not for the boot process, but an example of a replacement
> libc use) I use the firewall toolkit, it has been around for a _loooong_
> time (in software terms anyway) and has a firly odd licence (free for you
> to use, source available, cannot sell it) which is not compatable with the
> GPL. with glibc staticly linked this makes huge binaries, with libc5 they
> were a lot smaller. I would like to try to use this small libc for these
> proxies, but if the library is GPL, not LGPL I'm not allowed to.

Hmm, I think you can; you just can't redistribute it.  Can you even
redistribute fwtk on non-commercial terms?

-Doug
-- 
Let us cross over the river, and rest under the shade of the trees.
   --T. J. Jackson, 1863

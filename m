Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbTIXDqF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 23:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbTIXDqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 23:46:05 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:32163
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S261413AbTIXDqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 23:46:02 -0400
Date: Wed, 24 Sep 2003 05:46:12 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Larry McVoy <lm@work.bitmover.com>, Larry McVoy <lm@bitmover.com>,
       andrea@kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: Re: log-buf-len dynamic
Message-ID: <20030924034612.GQ16314@velociraptor.random>
References: <20030923221528.GP1269@velociraptor.random> <Pine.LNX.4.44.0309231524160.24527-100000@home.osdl.org> <20030924003652.GI16314@velociraptor.random> <20030924011951.GA5615@work.bitmover.com> <20030924020409.GL16314@velociraptor.random> <20030924022948.GA6496@work.bitmover.com> <20030924023928.GN16314@velociraptor.random> <20030924031602.GA7887@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030924031602.GA7887@work.bitmover.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 08:16:02PM -0700, Larry McVoy wrote:
> Yeah.  I'm using the Linux VM.  And it _still_ isn't up to what I managed
> to accomplish in SunOS.  Wake up, dude.  You aren't the first one to

if this would be really true, then why do you use linux then? I don't
understand. I've to exclude the reason is that it's free and open.

I heard arguments like yours for years and years from tons of different
people, 7 years ago I heard the very same again and again about linux
at large compared to other operative systems (way before I was using
linux myself).

Personally I don't believe you. I'm not saying the vm is too complex,
but it's heavily dominatd by details, it's simply not possible to
unique describe the vm in terms of algorithms like most parers do, and I
believe what we have in linux (mainline 2.4.23pre5 and 2.6 [modulo
rmap]) is very optimal.

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
	    svn://svn.kernel.org/linux-2.[46]/trunk

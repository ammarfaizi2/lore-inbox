Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265361AbTBLByJ>; Tue, 11 Feb 2003 20:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265424AbTBLByJ>; Tue, 11 Feb 2003 20:54:09 -0500
Received: from rth.ninka.net ([216.101.162.244]:28087 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S265361AbTBLByI>;
	Tue, 11 Feb 2003 20:54:08 -0500
Subject: Re: Linux 2.5.60
From: "David S. Miller" <davem@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0302110906100.13587-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0302110906100.13587-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Feb 2003 18:47:50 -0800
Message-Id: <1045018070.27960.0.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-11 at 09:06, Linus Torvalds wrote:
> > I will be looking into the possibility of carving up the generic
> > signal handling into a saner structure so we don't have this mess.
> 
> Good.

I already did some of this and I'll push to Linux right now.
It's enough for Sparc64, doing a few extensions to the hook
mechanism I created shouldn't be hard for what the m68k
and ARM folks are doing.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281663AbRKQBAG>; Fri, 16 Nov 2001 20:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281665AbRKQA74>; Fri, 16 Nov 2001 19:59:56 -0500
Received: from adsl-80-120-144.dab.bellsouth.net ([65.80.120.144]:51853 "EHLO
	midgaard.darktech.org") by vger.kernel.org with ESMTP
	id <S281663AbRKQA7m>; Fri, 16 Nov 2001 19:59:42 -0500
Date: Fri, 16 Nov 2001 19:59:58 -0500
From: Andreas Boman <aboman@nerdfest.org>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AMD SMP capability sanity checking.
Message-Id: <20011116195958.2676e3dd.aboman@nerdfest.org>
In-Reply-To: <Pine.LNX.4.30.0111170133290.32578-100000@Appserv.suse.de>
In-Reply-To: <3BF5B05F.9F727DD8@resilience.com>
	<Pine.LNX.4.30.0111170133290.32578-100000@Appserv.suse.de>
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i386-nerdfest-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Nov 2001 01:39:21 +0100 (CET)
Dave Jones <davej@suse.de> wrote:

> On Fri, 16 Nov 2001, Jeff Golds wrote:
> 
> > > Burning out a fuse to make the switch from MP->XP may affect more
> > > than just the cpuid capabilities. The fact is _we don't know_
> > Right, so why assume it doesn't work?
> 
> Because there are cases where it. does. not. work.
> 

Well the case you cited in your first mail turned out to be a GPM glitch,
solved by plugging in a mouse. Nothing to do with SMP what so ever. I have
yet to hear of any K7 cpu(s) that will _not_ work in SMP mode, care to
share a few real cases where that is the case? (ie all other factors ruled
out).

	Andreas

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271255AbTG2Es7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 00:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271245AbTG2Es7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 00:48:59 -0400
Received: from uswest-dsl-142-38.cortland.com ([209.162.142.38]:45318 "EHLO
	warez.scriptkiddie.org") by vger.kernel.org with ESMTP
	id S271240AbTG2Es5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 00:48:57 -0400
Date: Mon, 28 Jul 2003 21:48:52 -0700 (PDT)
From: Lamont Granquist <lamont@scriptkiddie.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: "David S. Miller" <davem@redhat.com>,
       Carlos Velasco <carlosev@newipnet.com>, bloemsaa@xs4all.nl,
       marcelo@conectiva.com.br, netdev@oss.sgi.com, linux-net@vger.kernel.org,
       layes@loran.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
In-Reply-To: <Pine.LNX.3.96.1030728222606.21100A-100000@gatekeeper.tmr.com>
Message-ID: <20030728213933.F81299@coredump.scriptkiddie.org>
References: <Pine.LNX.3.96.1030728222606.21100A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 28 Jul 2003, Bill Davidsen wrote:
> On Sun, 27 Jul 2003, David S. Miller wrote:
> > This particular case has been discussed to death in the past
> > and I really recommend people read up there before dragging this
> > out further.
>
> It will keep coming back because it's a real problem. I do agree that the
> hidden patch is not the desired way to solve the problem, but until there
> is a reasonable (not requiring a guru or large manual effort) solution
> people will keep bringing it up.

And it severely violates the principle of least surprise.  Its unfortunate
that this principle isn't more widely discussed and considered on lkml.

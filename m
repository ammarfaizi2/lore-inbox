Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271089AbTHQV7Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 17:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271091AbTHQV7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 17:59:16 -0400
Received: from [66.212.224.118] ([66.212.224.118]:56838 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S271089AbTHQV7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 17:59:15 -0400
Date: Sun, 17 Aug 2003 17:47:18 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Tom Sightler <ttsig@tuxyturvy.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Can't run Quake 3 on 2.6.0-test3-mm2
In-Reply-To: <1061154986.1775.2.camel@iso-8590-lx.zeusinc.com>
Message-ID: <Pine.LNX.4.53.0308171747020.9067@montezuma.mastecende.com>
References: <1061142481.14239.7.camel@iso-8590-lx.zeusinc.com> 
 <Pine.LNX.4.53.0308171528110.32300@montezuma.mastecende.com>
 <1061154986.1775.2.camel@iso-8590-lx.zeusinc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Aug 2003, Tom Sightler wrote:

> On Sun, 2003-08-17 at 15:28, Zwane Mwaikambo wrote:
> > On Sun, 17 Aug 2003, Tom Sightler wrote:
> > 
> > > I've recently upgraded to 2.6.0-test3-mm2 and part of my normal testing
> > > involves a quick run of q3demo.  Under this kernel the system segfaults
> > > when attempting to run this program.  Running strace I was able to
> > > determine that this fails when it attempts to open the pak0.pk3 as
> > > readonly.  Booting back to 2.6.0-test2-mm1 and the same program
> > > continues to work perfectly.
> > > 
> > > Any ideas what might be going on here?  I haven't found any other
> > > applications that exhibit such strange behavior but I'm still testing.
> > 
> > You may want to send over the entire strace log so that more people can 
> > have a look.
> 
> OK, it's not very long so I've just attached it here.  Thanks for any
> help.

And from -test2-mm1? =)

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVBVS7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVBVS7a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 13:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVBVS7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 13:59:30 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:36693 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261325AbVBVS7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 13:59:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=XPi9xPg+uI2YHK+FWOzU6wIfL1MMLQs2Qd7G40pD8NSnmS1coJfMZswZcf3UA6tU3OX5vhbEncb+KvM7MLif1rmcaSq0lvm7EvwIDEm9E2w9uSZBEqmxjvOi6kJvb3q2c6Itd0ZEHhgqWoV+JIXicKXEnFMFu/37QY7x6f2VfeE=
Message-ID: <a728f9f90502221059686284a7@mail.gmail.com>
Date: Tue, 22 Feb 2005 13:59:22 -0500
From: Alex Deucher <alexdeucher@gmail.com>
Reply-To: Alex Deucher <alexdeucher@gmail.com>
To: James Simmons <jsimmons@www.infradead.org>
Subject: Re: [Linux-fbdev-devel] Resource management.
Cc: Jon Smirl <jonsmirl@gmail.com>, Dave Airlie <airlied@gmail.com>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       adaplas@pol.net, dri-devel@lists.sourceforge.net,
       xorg@lists.freedesktop.org, Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.56.0502221719440.30102@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.56.0502211908520.14500@pentafluge.infradead.org>
	 <200502220653.01286.adaplas@hotpop.com>
	 <Pine.LNX.4.56.0502212313160.18148@pentafluge.infradead.org>
	 <9e473391050221170111610521@mail.gmail.com>
	 <Pine.LNX.4.56.0502220319330.20949@pentafluge.infradead.org>
	 <21d7e99705022120462cb9494c@mail.gmail.com>
	 <9e47339105022121234d0f7f73@mail.gmail.com>
	 <Pine.LNX.4.56.0502221719440.30102@pentafluge.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2005 17:23:03 +0000 (GMT), James Simmons
<jsimmons@www.infradead.org> wrote:
> 
> > As far as I know none of the significant contributors on either fbdev
> > or DRM are being paid to work on the project.
> 
> So I have noticed. There is much to do but no real man power. We are
> talking about this merging but at our rate it will take 5 years to happen.
> We don't have the man power to do this. So I'm not going to bother
> merging. Its all pipe dreams here.
> 
> 

with that attitude it's never gonna happen.  I work almost exclusively
on X, but once we get at least one sample driver done (probably
radeon, I would be more than happy to devote my limited development
resources to the new drm/fb super driver.  Right now the kernel FB
drivers have no benefit for me so I don't use/develop them.  The drm
just works and I'm more interested in the crtc/modes/outputs handling
than the command processor control stuff.  I think a lot of X
developers (and porobably IHVs) will get on board when this happens. 
X is undermanned as well, but we've managed to do a pretty good job of
supported a lot of features on a fair number of cards.

Alex

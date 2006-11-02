Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751968AbWKBVTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968AbWKBVTi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 16:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751974AbWKBVTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 16:19:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:28310 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751968AbWKBVTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 16:19:37 -0500
X-Authenticated: #20450766
Date: Thu, 2 Nov 2006 22:19:25 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Willy Tarreau <w@1wt.eu>, Valdis.Kletnieks@vt.edu, ray-gmail@madrabbit.org,
       "Martin J. Bligh" <mbligh@google.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Subject: Re: Linux 2.6.19-rc4
In-Reply-To: <20061101210422.GB691@uranus.ravnborg.org>
Message-ID: <Pine.LNX.4.60.0611022212460.10961@poirot.grange>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
 <20061030213454.8266fcb6.akpm@osdl.org> <Pine.LNX.4.64.0610310737000.25218@g5.osdl.org>
 <45477668.4070801@google.com> <2c0942db0610310834i6244c0abm10c81e984565ed8a@mail.gmail.com>
 <200610312053.k9VKr0Fm007201@turing-police.cc.vt.edu> <20061101063340.GA543@1wt.eu>
 <Pine.LNX.4.60.0611012123350.3736@poirot.grange> <20061101210422.GB691@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2006, Sam Ravnborg wrote:

> On Wed, Nov 01, 2006 at 09:26:13PM +0100, Guennadi Liakhovetski wrote:
> > Would it be possible to create a new verbosity level like V=2 to hide 
> > those "politeness" warnings so that by default everybody still would see 
> > all of them, but those needing to track regressions could use it and only 
> > see severe ones?
> 
> I suggest you try out make V=2 one day.
> It does not compress warnings but tells you why something got rebuild.

Ok, take V=-1, it is more logical as it reduces verbosity and, hopefully, 
not taken yet:-)

Thanks
Guennadi
---
Guennadi Liakhovetski

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbUBZBSt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 20:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbUBZBSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 20:18:49 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:21252 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S261463AbUBZBSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 20:18:47 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3
Date: Thu, 26 Feb 2004 02:18:19 +0100
User-Agent: KMail/1.6.1
Cc: Nick Piggin <piggin@cyberone.com.au>, Mike Fedyk <mfedyk@matchmail.com>,
       Andrew Morton <akpm@osdl.org>
References: <20040222172200.1d6bdfae.akpm@osdl.org> <403D1347.8090801@matchmail.com> <403D468D.2090901@cyberone.com.au>
In-Reply-To: <403D468D.2090901@cyberone.com.au>
X-Operating-System: Linux 2.4.20-wolk4.10s i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200402260217.49239@WOLK>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 February 2004 02:06, Nick Piggin wrote:

Hi,

> >>> What about Nick's fix up patch for the two patches above?  Should I
> >>> include that one also?
> > I'm running 2.6.3-mm3-486-fazok (nick's patch), and it has improved my
> > slab usage greatly.  It was averaging 500MB-700MB slab.  Now slab is
> > ~230MB, and page cache is ~700MB
> That is a much better sounding ratio. Of course that doesn't mean much
> if performance is worse. Slab might be getting reclaimed a little bit
> too hard vs pagecache now.

sorry for not following this thread, but where do I find the mm3 rollup patch 
this thread is talking about? akpm's directory does not contain it, or I am 
blind b/c it isn't named like that or similar ;>

ciao, Marc

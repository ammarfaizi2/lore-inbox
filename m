Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262722AbVG3Ckp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262722AbVG3Ckp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 22:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbVG3Cko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 22:40:44 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:5097 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262722AbVG3CkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 22:40:11 -0400
Date: Fri, 29 Jul 2005 19:39:52 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: astralstorm@gorzow.mm.pl, mkrufky@m1k.net, linux-kernel@vger.kernel.org
Subject: Re: MM kernels - how to keep on the bleeding edge?
Message-Id: <20050729193952.125d1377.pj@sgi.com>
In-Reply-To: <20050726161149.0c9c36fa.akpm@osdl.org>
References: <20050726185834.76570153.astralstorm@gorzow.mm.pl>
	<42E692E4.4070105@m1k.net>
	<20050726221506.416e6e76.astralstorm@gorzow.mm.pl>
	<42E69C5B.80109@m1k.net>
	<20050726144149.0dc7b008.akpm@osdl.org>
	<20050727004932.1b25fc5d.astralstorm@gorzow.mm.pl>
	<20050726161149.0c9c36fa.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta4 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> Ho hum.  Adding a "why
> this was dropped" to the email seemed too tricky.

I can't speak for all the other clue deprived gits out here, but for
me at least just adding a generic "If this patch was sent on to Linus,
that might be one possible reason it is now dropped from *-mm." boiler
plate sentence to the existing notice would have been sufficient to
calm my nerves and stop me from pestering you with stupid "what what
why did you kill my patch ?!?" queries.

No need for articial intelligence to condition the message on whether
the patch actually was sent to Linus, or not.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

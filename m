Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933192AbWKNAAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933192AbWKNAAH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 19:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933195AbWKNAAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 19:00:07 -0500
Received: from iabervon.org ([66.92.72.58]:29968 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S933192AbWKNAAE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 19:00:04 -0500
Date: Mon, 13 Nov 2006 19:00:02 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Paul Fulghum <paulkf@microgate.com>
cc: Andrew Morton <akpm@osdl.org>, Krzysztof Halasa <khc@pm.waw.pl>,
       Jeff Garzik <jeff@garzik.org>,
       =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: linux-2.6.19-rc5-g088406bc build #120 failed
In-Reply-To: <4558FC91.5020507@microgate.com>
Message-ID: <Pine.LNX.4.64.0611131845100.9789@iabervon.org>
References: <200611130943.42463.toralf.foerster@gmx.de> <4558860B.8090908@garzik.org>
 <45588895.7010501@microgate.com> <m3ejs78adt.fsf@defiant.localdomain>
 <4558BF72.2030408@microgate.com> <m3ac2v6phw.fsf@defiant.localdomain>
 <4558E652.1080905@microgate.com> <20061113150616.5bd122ae.akpm@osdl.org>
 <4558FC91.5020507@microgate.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2006, Paul Fulghum wrote:

> I'm not really sure how to preempt objections
> with the changelog. The objections seemed to be
> against the fundemental mechanism of the patch.

In your changelog, explain why you're doing things differently from how 
some people will suggest. That way, when new people read the new thread 
started by your new patch, they see the results of the previous cycle and 
don't rehash old arguments. This also means that people in the future 
wondering why the code is weird there can find out without extensive 
mailing list searching.

	-Daniel
*This .sig left intentionally blank*

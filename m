Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267195AbUIEUSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267195AbUIEUSr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 16:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267197AbUIEUSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 16:18:47 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:38209 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267195AbUIEUSo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 16:18:44 -0400
Message-ID: <d577e569040905131870fa14a3@mail.gmail.com>
Date: Sun, 5 Sep 2004 16:18:43 -0400
From: Patrick McFarland <diablod3@gmail.com>
Reply-To: Patrick McFarland <diablod3@gmail.com>
Illegal-Object: Syntax error in To: address found on vger.kernel.org:
	To:	"Michel  =?ISO-8859-1?Q?=20D=E4nzer=22?= <michel@daenzer.net>"
			^-missing closing '"' in token
Subject: Re: [BUG] r200 dri driver deadlocks
Cc: dri-devel@lists.sf.net, linux-kernel@vger.kernel.org
In-Reply-To: <1094406055.31464.118.camel@admin.tel.thor.asgaard.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <d577e569040904021631344d2e@mail.gmail.com>
	 <1094321696.31459.103.camel@admin.tel.thor.asgaard.local>
	 <d577e56904090413365f5e223d@mail.gmail.com>
	 <1094366099.31457.112.camel@admin.tel.thor.asgaard.local>
	 <d577e56904090501224f252dbc@mail.gmail.com>
	 <1094406055.31464.118.camel@admin.tel.thor.asgaard.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)

On Sun, 05 Sep 2004 13:40:54 -0400, Michel Dänzer <michel@daenzer.net> wrote:
> On Sun, 2004-09-05 at 04:22 -0400, Patrick McFarland wrote:
> > On Sun, 05 Sep 2004 02:34:59 -0400, Michel Dänzer <michel@daenzer.net> wrote:
> > >
> > > Where did you get r200_dri.so from?
> >
> > From the one that comes with the Deb X I mentioned above.
> 
> Please try something newer, e.g. my xlibmesa-gl1-dri-trunk or a binary
> snapshot from dri.sf.net.

That shouldn't matter, should it? The userland stuff should never lock
the machine up.
I'll test it anyhow, though.

-- 
Patrick "Diablo-D3" McFarland || diablod3@gmail.com
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, we'd 
all be running around in darkened rooms, munching magic pills and listening to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989

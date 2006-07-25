Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932480AbWGYVHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbWGYVHW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 17:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbWGYVHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 17:07:22 -0400
Received: from mail.gmx.net ([213.165.64.21]:44452 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932480AbWGYVHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 17:07:20 -0400
X-Authenticated: #428038
Date: Tue, 25 Jul 2006 23:07:16 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Nathan Scott <nathans@sgi.com>, stable@kernel.org
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17.[1-6] XFS Filesystem Corruption, Where is 2.6.17.7?
Message-ID: <20060725210716.GC4807@merlin.emma.line.org>
Mail-Followup-To: Nathan Scott <nathans@sgi.com>, stable@kernel.org,
	Justin Piszcz <jpiszcz@lucidpixels.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0607241224010.10896@p34.internal.lan> <20060725084624.C2090627@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060725084624.C2090627@wobbly.melbourne.sgi.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12 (2006-07-17)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2006, Nathan Scott wrote:

> On Mon, Jul 24, 2006 at 12:29:48PM -0400, Justin Piszcz wrote:
> > Beginning at 2.6.17 to 2.6.17.6, there is a serious XFS bug that results 
> > in filesystem corruption, there was a 1 line bugfix patch that was 
> > released recently and I was wondering when 2.6.17.7 would be released with 
> > that patch? ...
> 
> I think everyone's been real busy leading up to OLS, and many folks
> are probably taking some time off in Canada too.  I know I would be
> if I was over there. ;)

I don't mean to be nasty, but the effect this has on readers, in spite
of the smiley, is that "Linux hasn't grown up yet if they find Ottawa so
much kewler than fixing a simple bug".  Meaning: the downside of public
discussion is that it's easy to be mistaken.

A serious suggestion is, providing that the arguments presented (people
busy with OLS preparations and long review queue for 2.6.17.N+1):

How about doing 2.6.17.7 as an interim release fixing just what is known
to be critical at the point of the release, and then review the rest for
2.6.17.8? That would nicely fit the release early, release often - users
like that particularly for bug fixes.

(Please remember to Cc: replies, particularly I'm not subscribed to stable)

-- 
Matthias "2.6.16.27 works for my Samba" Andree

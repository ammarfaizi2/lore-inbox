Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271797AbRICUMt>; Mon, 3 Sep 2001 16:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271798AbRICUMj>; Mon, 3 Sep 2001 16:12:39 -0400
Received: from dsl-212-135-211-72.dsl.easynet.co.uk ([212.135.211.72]:59653
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S271797AbRICUMf>; Mon, 3 Sep 2001 16:12:35 -0400
Date: Mon, 3 Sep 2001 21:11:24 +0100 (BST)
From: Simon Hay <simon@haywired.org>
X-X-Sender: <sjeh@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Multiple monitors
In-Reply-To: <20010903214829.B17488@unthought.net>
Message-ID: <Pine.LNX.4.33.0109032107280.2297-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Sep 2001, Jakob Østergaard wrote:

> XFree86 has pretty good support for multiple heads.
>
> If you tie an xterm to the root window, I guess you would get something
> pretty close to what you're looking for.  Or, configure some window manager
> properly to do exactly what you want.
>

I had considered doing that - I believe that some of the framebuffer
code supports multiple heads as well(?) - but in this particular case it
wasn't appropriate - the whole point was to demonstrate what could be
achieved using only a command line ;-)  Also, though, on dedicated servers
etc. I'd rather not be running X if I didn't have to.  Would this be a
particularly difficult thing to implement as a kernel patch?  I'd like to
try to get involved in kernel development at some point and am looking for
something to ease myself in slowly - preferably something useful but
unimportant ;-)  Are there any show stoppers involved here - or does
anyone have any other ideas?

Thanks in advance,

Simon


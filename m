Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313679AbSDURsz>; Sun, 21 Apr 2002 13:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313680AbSDURsy>; Sun, 21 Apr 2002 13:48:54 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:11172 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S313679AbSDURsx>;
	Sun, 21 Apr 2002 13:48:53 -0400
Date: Sun, 21 Apr 2002 13:48:51 -0400
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Larry McVoy <lm@work.bitmover.com>, CaT <cat@zip.com.au>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org
Subject: Re: Suggestion re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020421134851.B7828@havoc.gtf.org>
In-Reply-To: <Pine.LNX.4.44.0204201039130.19512-100000@home.transmeta.com> <E16yfW9-0000aZ-00@starship> <20020421171629.GK4640@zip.com.au> <20020421104046.J10525@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 10:40:46AM -0700, Larry McVoy wrote:
[...]

That reminds me.

Can you get the bkbits.net interface to spit out text/plain GNU-style
patches?

IIRC the web interface currently spits out HTML-ized per-cset patches,
so I am hoping it would be trivial to get you guys to change that to
text/plain, or offer text/plain in addition to HTML.

That would IMO eliminate an objection or two about the opaqueness of BK,
and also eliminate the need for any bkbits.net user to generate per-cset
patches.  They would need only to give a URL to a CGI which spits out
text/plain GNU-style patches.

	Jeff




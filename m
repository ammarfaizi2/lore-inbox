Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbTDZSKs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 14:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbTDZSKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 14:10:48 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48652 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262810AbTDZSKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 14:10:45 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Flame Linus to a crisp!
Date: Sat, 26 Apr 2003 18:22:50 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b8eipq$fpk$1@penguin.transmeta.com>
References: <20030424201522.G1425@almesberger.net> <Pine.GSO.4.21.0304261459210.10838-100000@vervain.sonytel.be>
X-Trace: palladium.transmeta.com 1051381370 31611 127.0.0.1 (26 Apr 2003 18:22:50 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 26 Apr 2003 18:22:50 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.GSO.4.21.0304261459210.10838-100000@vervain.sonytel.be>,
Geert Uytterhoeven  <geert@linux-m68k.org> wrote:
>
>Hence the development rate of Linux will go down, since you cannot use your
>Linux development box running your own development kernel for anything else,
>since that would require a signed kernel.

Quite frankly, I suspect a much more likely issue is going to be that
DRM doesn't matter at all in the long run.

Maybe I'm just a blue-eyed optimist, but all the _bad_ forms of DRM look
to be just fundamentally doomed.  They are all designed to screw over
customers and normal users, and in the world I live in that's not how
you make friends (or money, which ends up being a lot more relevant to
most companies). 

Think about it.  Successful companies give their customers what they
_want_.  They don't force-feed them.  Look at the total and utter
failure of commercial on-line music: the DRM things that has been tried
have been complete failures.  Why? I'm personally convinced the cost is
only a minor issue - the _anti_convenience of the DRM crap (magic file
formats that only work with some players etc) is what really kills it in
the end. 

And that's a fundamental flaw in any "bad" DRM. It's not going away. 

We've seen this before. Remember when dongles were plentiful in the
software world? People literally had problems with having dongles on top
of dongles to run a few programs. They all died out, simply because
consumers _hate_ that kind of lock-in thing.

This is part of the reason why I have no trouble with DRM - let the
people who want to try it go right ahead. They'll only screw themselves
over in the end, because the people who do _not_ try to control their
customers will in the end have the superior product. It's that simple.

As to the quake-on-PC issue - it's a completely made-up example, but it
does show the same thing.  Nobody in their right mind would ever _do_ a
DRM-enabled quake on a PC, because it limits you too much.  PC's are
_designed_ ot be flexible - that's what makes the PC's.  DRM on a PC is
a totally braindead idea, and I _hope_ Microsoft goes down that path
because it will kill them in the end. 

The place where client authentication makes sense is on specialty boxes. 
On a dedicated game machine it's an _advantage_ to verify the client,
exactly to make sure that nobody is cheating.  I think products like the
PS2 and the Xbox actually make _sense_ - they make it convenient for the
user, and yes they use DRM techniques to "remove rights", but that's
very much by design and when you buy the box 99.9% of all people buy it
_because_ it only does one thing.

		Linus

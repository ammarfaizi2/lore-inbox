Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279927AbRKNBX4>; Tue, 13 Nov 2001 20:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279930AbRKNBXp>; Tue, 13 Nov 2001 20:23:45 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:41233 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S279927AbRKNBXd>; Tue, 13 Nov 2001 20:23:33 -0500
Message-ID: <3BF1C72C.2B5B5EB3@linux-m68k.org>
Date: Wed, 14 Nov 2001 02:21:48 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Next cut of new devfs core
In-Reply-To: <200111131855.fADIt2Q26535@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:

> If people could try this out and report back, I'd appreciate it.

Do you have any other intentions for us than to just "try this out"? If
not then an URL to the patch would suffice instead of flooding the list
with lots of 80kB patches.
If you want other feedback, I would greatly appreciated it, if you would
make it a bit easier for other developers. Incremental patches would
help to see what actually changed, or even better make them available
through CVS (I think I suggested that before).
Your coding style was already mentioned as well, so I'm not going to
repeat that. Anyway, an important point you should understand is that,
you might be the devfs maintainer, but devfs is not an isolated project.
The common project is Linux, which is maintained by lots of people, to
make such a cooperative development effort possible these people have to
agree on some basic rules. One of these rules is the coding style, Linus
might not care too much about it, but by now you should have noticed
several other developers do.
To maintain a high code quality a constant code review is necessary, a
single person can mistakes, that's normal, but it's important to learn
from mistakes. That also requires that other people are able review the
code, but you aren't making it very easy to review your code. If you're
going to continue with this attitude I can only support Al to split the
code. Sorry, there isn't much room for an ego trip, if you're not able
to deliver high quality code (for whatever reasons of which we got
enough by now).

bye, Roman


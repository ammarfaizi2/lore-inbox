Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290958AbSBFXyi>; Wed, 6 Feb 2002 18:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290967AbSBFXy2>; Wed, 6 Feb 2002 18:54:28 -0500
Received: from bitmover.com ([192.132.92.2]:36298 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S290958AbSBFXyT>;
	Wed, 6 Feb 2002 18:54:19 -0500
Date: Wed, 6 Feb 2002 15:54:18 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Roman Zippel <zippel@linux-m68k.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Message-ID: <20020206155418.B21185@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3C618AFD.7148EEAA@linux-m68k.org> <Pine.LNX.4.33.0202061529280.1714-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0202061529280.1714-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Feb 06, 2002 at 03:36:01PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2002 at 03:36:01PM -0800, Linus Torvalds wrote:
> do) I still usually need to do at least some minimal editing of the commit
> message etc (removing stuff like "Hi Linus" etc).

And I think once we finalize the generic patch comment format, you will
be able to scan it email, see it looks good, and dump it to apply and
move on.  Then people can send you mail like what is below and it's 
painless.  Aside from the coffee/tea issues.

Hi Linus, 

How's the wife and kids, mine are fine, here's a patch that makes coffee
from /dev/coffee bits, see the changelog.  Next week we will send you
the patch which removes /dev/emacs and replaces it with /dev/vi, the
one true editor.  I trust you will have no issues with these patches.

Thank you,

Joe Hacker.

### Comments for ChangeSet
This is the coffee patch.  It is the one true coffee patch and it should
put an end to the coffee versus tea debate.  There is no /dev/tea, there
is only a /dev/coffee, in spite of our best efforts to implement /dev/tea,
we could not fix the problem of multiple Oopses on SMP machines when we
did a "cat /dev/tea > /dev/cup".  "cat /dev/coffee > /dev/cup" always
works, so we think this is proof positive that coffee is better than tea.

### Comments for drivers/char/coffee.c
I like coffee, I don't like tea,
I'm as happy as a little wired bee.

### Comments for drivers/char/tea.c
Didn't work.  It's a sign from above.

<diffs>


:-)

Yup, a little punchy back here at BitMover, but trying to maintain a sense
of humor.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 

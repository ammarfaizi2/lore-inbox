Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264426AbUEYB2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264426AbUEYB2E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 21:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264429AbUEYB2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 21:28:04 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:47295 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264426AbUEYB2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 21:28:00 -0400
Subject: Re: [RFD] Explicitly documenting patch submission
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1085439926.951.971.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 May 2004 19:05:26 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[this didn't have the right subject before, sorry]

Linus Torvalds writes:

> (Seriously, while nobody has actually complained about
> the suggested rules, I don't think anybody should feel
> compelled to do the sign-off before we've had more
> time to let people argue over it. People who feel 
> comfortable with the suggestion are obviously
> encouraged to start asap, though).

I had been hoping someone had just forged your email
address. :-/  You're not known for bureaucracy.

The wordy mix-case aspect is kind of annoying, and for
all that we don't get to differentiate actions.
I count:

1. came up with the design ideas
2. wrote the original patch
3. reviewed and passed on
4. modified
5. blindly passed on

Maybe "blindly passed on" needs nothing. So I'm
thinking, if we must bother with all this...

designed:
authored:
reviewed:
modified:

Add "pirated:" if you like, so that searching for
pirated code is easier than checking the evil bit.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261395AbSKBTNu>; Sat, 2 Nov 2002 14:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261400AbSKBTNu>; Sat, 2 Nov 2002 14:13:50 -0500
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:15687 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S261395AbSKBTNs>; Sat, 2 Nov 2002 14:13:48 -0500
Date: Sat, 2 Nov 2002 11:28:17 -0800 (PST)
From: "Matt D. Robinson" <yakker@aparity.com>
To: Brad Hards <bhards@bigpond.net.au>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: [lkcd-devel] Re: What's left over.
In-Reply-To: <200211022136.51039.bhards@bigpond.net.au>
Message-ID: <Pine.LNX.4.44.0211021124270.28078-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Nov 2002, Brad Hards wrote:
|>I applied the patches, and reported some issues.
|>http://marc.theaimsgroup.com/?l=linux-kernel&m=103520434201014&w=2
|>I see no signs that any of them have been addressed, although I haven't tried 
|>a really recent set.

We did put your fixes in, if they don't work, let me know.

|>LKCD doesn't really seem to do anything for me - it wouldn't really worry me 
|>if it went in (since I don't have to maintain it - it isn't near any of my 
|>code), but I'd really prefer that having the _CONFIG option set to N didn't 
|>make the kernel any bigger, or change any code paths.
|>
|>Is this unreasonable?

Absolutely not.  I would expect most people to not use it, and I
would hope that most distributions would build it as a module but
not turn it on (unless they really wanted it on by default).

|>Brad
|>
|>BTW: I admit that I'd be pretty pissed if Linus said that my code was 
|>"stupid", but life isn't reasonable or fair. Take a few days off LKCD, go for 
|>a few walks, and worry about how to get it integrated after that.

It's neither here nor there anymore.  I think if companies like
Red Hat don't want it turned on, that's fine, but they should at
least allow their customers to have it available to them for
use, if that's what they want.

Of course, I'm not going to go through all the reasons why there's
a major disconnect between Linux distributions and hardware vendors,
but suffice it to say that's the root of the problem here.

--Matt


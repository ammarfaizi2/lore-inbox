Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287217AbRL2W7r>; Sat, 29 Dec 2001 17:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287214AbRL2W7i>; Sat, 29 Dec 2001 17:59:38 -0500
Received: from waste.org ([209.173.204.2]:214 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S287217AbRL2W7X>;
	Sat, 29 Dec 2001 17:59:23 -0500
Date: Sat, 29 Dec 2001 16:59:13 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The direction linux is taking
In-Reply-To: <E16KSTn-00060i-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.43.0112291652430.18183-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2001, Alan Cox wrote:

> > It never shows up in the maintainer's inbox, leaving them more time to
> > address the remainder. And fewer of the increasingly bitter complaints of
> > dropped patches.
>
> Most mangled diffs I get are caused by pine. Fixing pine would do more
> wonders than any magical patchbot.

Unfortunately not an option. Cloning pine, though..

By the way, the 'forgot to include the patch' syndrome seems to be a
common problem with Mutt..

> I also get patches and changes from
> people who quite genuinely either can't mail me unmangled diffs (eg the
> lotus corporate mail policy afflicted) or are from people who may really
> know their stuff and even be the vendor but are not familiar with the
> patch/diff tools. A robot isn't going to teach them.

The other part of patchbot is to auto-bounce stuff off the queue when it
no longer applies to the current rev (garbage collection). And to possibly
simplify manually bouncing patches with common comments. And exposing the
queue to the outside world. Allowing web-based patch upload might work
around the braindead mail agent problem.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."


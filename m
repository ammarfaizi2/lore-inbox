Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285048AbRL2T6n>; Sat, 29 Dec 2001 14:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285384AbRL2T6d>; Sat, 29 Dec 2001 14:58:33 -0500
Received: from waste.org ([209.173.204.2]:18386 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S285048AbRL2T61>;
	Sat, 29 Dec 2001 14:58:27 -0500
Date: Sat, 29 Dec 2001 13:58:21 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Larry McVoy <lm@bitmover.com>
cc: Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        <linux-kernel@vger.kernel.org>
Subject: Re: The direction linux is taking
In-Reply-To: <20011229113749.D19306@work.bitmover.com>
Message-ID: <Pine.LNX.4.43.0112291341360.18183-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2001, Larry McVoy wrote:

> [patchbot stuff]

> If you have N people trying to patch the same file, you'll require N
> releases and some poor shlep is going to have to resubmit their patch
> N-1 times before it gets in.

The point is to have N patches queued against rev x that apply cleanly by
themselves before even considering merging. The idea is to cut out as much
bogosity beforehand as possible. Turning them locally into 'changesets' or
whatever to perform the actual merge after deciding which ones you're
going to try applying is orthogonal.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132607AbRDXAWP>; Mon, 23 Apr 2001 20:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132614AbRDXAWG>; Mon, 23 Apr 2001 20:22:06 -0400
Received: from waste.org ([209.173.204.2]:25872 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S132607AbRDXAVl>;
	Mon, 23 Apr 2001 20:21:41 -0400
Date: Mon, 23 Apr 2001 19:21:36 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Marko Kreen <marko@l-t.ee>, "Eric S. Raymond" <esr@snark.thyrsus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: comments on CML 1.1.0
In-Reply-To: <20010414164914.A12838@thyrsus.com>
Message-ID: <Pine.LNX.4.30.0104231911010.21186-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Apr 2001, Eric S. Raymond wrote:

> > * the colors are hard to see (red/blue on black).  Probably
> >   matter of terminal settings.  I do not have any productive
> >   ideas tho...  Probably to get best experience to as much
> >   people as possible the less colors are used the better.
> >
> >   The 'blue: last visited submenu' is unnecessary.  Especially
> >   because it later turns green...  And the 'red' vs. 'green'
> >   thing.  I guess the green should be used for 'visited entries'
> >   too.  Now the red means like 'Doh.  So I should not have
> >   touched this?'.  Confusing.
> >
> >   In other words: if there are too much colors, they become
> >   a thing that should be separately learned, not a helpful
> >   aid.
> >
> >   All this IMHO ofcourse.  Colors are 'matter of taste' thing
> >   so there probably is not exact Rigth Thing.
>
> You make good points.  In the 1.1.1, blue and yellow/brown will be gone;
> it's just green for everything visited.

I haven't had a chance to take a look, but a heads-up about color
confusion issues. There may be no right thing, but there are plenty of
wrong things. For instance, for about 4% of people (8% of males), RGB
FFFF00 and 00FF00 are nearly indistiguishable, as are FF00FF and 0000FF.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289090AbSAGCXB>; Sun, 6 Jan 2002 21:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289083AbSAGCWv>; Sun, 6 Jan 2002 21:22:51 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:43272 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289082AbSAGCWd>;
	Sun, 6 Jan 2002 21:22:33 -0500
Date: Mon, 7 Jan 2002 00:22:09 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Ken Brownfield <brownfld@irridia.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <Pine.LNX.4.33L.0201062342150.872-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.33L.0201070021180.872-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jan 2002, Rik van Riel wrote:
> On Sat, 5 Jan 2002, Stephan von Krawczynski wrote:
>
> > I am pretty impressed by Martins test case where merely all VM patches
> > fail with the exception of his own :-)
>
> No big wonder if both -aa and -rmap only get tested without swap ;)

To be clear ... -aa and -rmap should of course also work
nicely without swap, no excuses for the bad behaviour
shown in Martin's test, but at the moment they simply
don't seem tuned for it.

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293648AbSCAT2t>; Fri, 1 Mar 2002 14:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293650AbSCAT2j>; Fri, 1 Mar 2002 14:28:39 -0500
Received: from pc132.utati.net ([216.143.22.132]:46472 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S293648AbSCAT2d>; Fri, 1 Mar 2002 14:28:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>, Hans Reiser <reiser@namesys.com>
Subject: Re: A modest proposal -- We need a patch penguin
Date: Fri, 1 Mar 2002 14:29:21 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Rik van Riel <riel@conectiva.com.br>, Larry McVoy <lm@bitmover.com>,
        Andre Hedrick <andre@linux-ide.org>,
        Linus Torvalds <torvalds@transmeta.com>, <green@thebsh.namesys.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L2.0202250855310.11464-100000@dragon.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.33L2.0202250855310.11464-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020301193718.B244B4EC@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 February 2002 12:13 pm, Randy.Dunlap wrote:
> On Fri, 22 Feb 2002, Hans Reiser wrote:
> | We need to move from discussing whether Linus can scale to whether the
> | Linux Community can scale.
>
> I have to agree with much of what Hans has written here.
>
> and one of the biggest things that would help in this regard, IMHO,
> is to (dare I say "require") provide documentation for kernel
> API changes or semantics.  "Read the source" or "Use the source"
> doesn't scale well either, when 10K kernel developers are
> trying to use a new widget in 2.5.4, but they all ask questions
> on lkml about how it's done.
>
> Let's keep Documentation/* stuff up to date.  Whether it's in
> text or DocBook format doesn't matter much.
> Or have web pages for it if that's preferred by the project or
> individual(s).

Random comment:

It's design documentation that's needed.  Looking at the code you can see 
what it's doing, but you sometimes have to read an amazing amount of it to 
even guess at WHY...  The code doesn't always tell you about the author's 
intentions, just the implementation.  And sometimes the code is wrong 
anyway...

I believe the kernelnewbies project is working on this, but haven't been able 
to follow it.  (I just moved back to Austin, am recovering from food 
poisioning, picking an old job back up...  Not following much of anything at 
the moment...)

>   ~Randy

Rob

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316666AbSGQUWp>; Wed, 17 Jul 2002 16:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316667AbSGQUWp>; Wed, 17 Jul 2002 16:22:45 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:24068 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S316666AbSGQUWo>; Wed, 17 Jul 2002 16:22:44 -0400
Date: Wed, 17 Jul 2002 17:25:27 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Daniel Phillips <phillips@arcor.de>
cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/13] minimal rmap
In-Reply-To: <Pine.LNX.4.44L.0207171721470.12241-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44L.0207171725160.12241-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2002, Rik van Riel wrote:
> On Wed, 17 Jul 2002, Daniel Phillips wrote:
>
> > Yes, I've always felt that at least one new list is needed to do the job
> > properly, and there are other considerations as well.
>
> > Obviously we don't want to be adding new lists and other experimental
> > cruft just now.
>
> I know it's against a long-standing tradition, but I'd really
> like to get changes like this in _before_ the code change.

Code _freeze_ that is, duh.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/


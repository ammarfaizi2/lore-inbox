Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316675AbSGQUc7>; Wed, 17 Jul 2002 16:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316678AbSGQUc6>; Wed, 17 Jul 2002 16:32:58 -0400
Received: from dsl-213-023-038-064.arcor-ip.net ([213.23.38.64]:57534 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316675AbSGQUc6>;
	Wed, 17 Jul 2002 16:32:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: [patch 1/13] minimal rmap
Date: Wed, 17 Jul 2002 22:36:33 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0207171725160.12241-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.44L.0207171725160.12241-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17UvXF-0004Pu-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 July 2002 22:25, Rik van Riel wrote:
> On Wed, 17 Jul 2002, Rik van Riel wrote:
> > On Wed, 17 Jul 2002, Daniel Phillips wrote:
> >
> > > Yes, I've always felt that at least one new list is needed to do the job
> > > properly, and there are other considerations as well.
> >
> > > Obviously we don't want to be adding new lists and other experimental
> > > cruft just now.
> >
> > I know it's against a long-standing tradition, but I'd really
> > like to get changes like this in _before_ the code change.
> 
> Code _freeze_ that is, duh.

Is the halloween freeze a code freeze?  I thought it was a feature freeze.

-- 
Daniel

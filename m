Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263958AbRFSHjI>; Tue, 19 Jun 2001 03:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263965AbRFSHi7>; Tue, 19 Jun 2001 03:38:59 -0400
Received: from www.wen-online.de ([212.223.88.39]:61457 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S263960AbRFSHiu>;
	Tue, 19 Jun 2001 03:38:50 -0400
Date: Tue, 19 Jun 2001 09:37:46 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: root <root@norma.kjist.ac.kr>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 VM & swap question
In-Reply-To: <Pine.LNX.4.33.0106190312210.1376-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0106190935580.306-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2001, Rik van Riel wrote:

> On Tue, 19 Jun 2001, Mike Galbraith wrote:
> > On Mon, 18 Jun 2001, root wrote:
> >
> > > Regarding to the discussion on the swap size,
> > >
> > > Recently, Rick van Riel posted a message that there is a bug
> > > related to "reclaiming" the swap, and said that it is on his
> > > TODO list.
> >
> > That's fixed.
>
> It's not. We don't reclaim swap space when we run low on
> free swap space (by freeing up the space in swap of stuff
> which is in RAM).

Ah.. different problem.

	-Mike


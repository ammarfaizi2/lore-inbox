Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290340AbSAXVqm>; Thu, 24 Jan 2002 16:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290343AbSAXVqe>; Thu, 24 Jan 2002 16:46:34 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15879 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290340AbSAXVqU>; Thu, 24 Jan 2002 16:46:20 -0500
Date: Thu, 24 Jan 2002 13:39:26 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
        Richard Gooch <rgooch@atnf.csiro.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH]: Fix MTRR handling on HT CPUs (improved)
In-Reply-To: <Pine.LNX.4.33.0201242145400.1046-100000@biker.pdb.fsc.net>
Message-ID: <Pine.LNX.4.33.0201241338030.15092-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Jan 2002, Martin Wilck wrote:
>
> I strongly suspected somebody else must have hit this problem before, but
> intensive research did show up nothing. Also my first post on LK
> received no "hey, that's old stuff" answer. So here I go.

There is a patch from Asit Mallik floating around, which I've applied in
my tree. Most of us mere mortals can't test it yet, of course.

		Linus


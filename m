Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290409AbSAXWan>; Thu, 24 Jan 2002 17:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290389AbSAXWae>; Thu, 24 Jan 2002 17:30:34 -0500
Received: from ns.suse.de ([213.95.15.193]:10000 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290378AbSAXWaY>;
	Thu, 24 Jan 2002 17:30:24 -0500
Date: Thu, 24 Jan 2002 23:30:22 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
        Richard Gooch <rgooch@atnf.csiro.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH]: Fix MTRR handling on HT CPUs (improved)
In-Reply-To: <Pine.LNX.4.33.0201241338030.15092-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0201242329220.19774-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002, Linus Torvalds wrote:

> > I strongly suspected somebody else must have hit this problem before, but
> > intensive research did show up nothing. Also my first post on LK
> > received no "hey, that's old stuff" answer. So here I go.
> There is a patch from Asit Mallik floating around, which I've applied in
> my tree. Most of us mere mortals can't test it yet, of course.

There are at least three versions of that patch by different people.
Marcelo pointed me ot one from someone at Intel. I suspect they;re all
largely the same though.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs


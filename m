Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316747AbSGQUrx>; Wed, 17 Jul 2002 16:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316746AbSGQUrw>; Wed, 17 Jul 2002 16:47:52 -0400
Received: from ns.suse.de ([213.95.15.193]:55046 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316753AbSGQUrI>;
	Wed, 17 Jul 2002 16:47:08 -0400
Date: Wed, 17 Jul 2002 22:50:06 +0200
From: Dave Jones <davej@suse.de>
To: Daniel Phillips <phillips@arcor.de>
Cc: Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@zip.com.au>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/13] minimal rmap
Message-ID: <20020717225006.C9489@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Daniel Phillips <phillips@arcor.de>,
	Rik van Riel <riel@conectiva.com.br>,
	Andrew Morton <akpm@zip.com.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0207171725160.12241-100000@imladris.surriel.com> <E17UvXF-0004Pu-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17UvXF-0004Pu-00@starship>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 10:36:33PM +0200, Daniel Phillips wrote:

 > > Code _freeze_ that is, duh.
 > Is the halloween freeze a code freeze?  I thought it was a feature freeze.

Your thinking is correct. No new features after halloween, but
obviously code *fixing* those that made it before the cut-off
will still be taken right up to 2.6.0

I have visions of pre-freeze October as everyone goes mad rushing
to get their last minute features in, and then post-freeze November
the endless.  "No really, it's just a fix!" mails.

Fun times lie ahead.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

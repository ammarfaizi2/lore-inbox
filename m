Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315329AbSDWUQl>; Tue, 23 Apr 2002 16:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315333AbSDWUQk>; Tue, 23 Apr 2002 16:16:40 -0400
Received: from bitmover.com ([192.132.92.2]:15540 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S315329AbSDWUQj>;
	Tue, 23 Apr 2002 16:16:39 -0400
Date: Tue, 23 Apr 2002 13:16:38 -0700
From: Larry McVoy <lm@bitmover.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5 activity by directory
Message-ID: <20020423131638.J26818@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
In-Reply-To: <200204231936.g3NJabC29433@work.bitmover.com> <Pine.NEB.4.44.0204232201520.11258-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2002 at 10:09:17PM +0200, Adrian Bunk wrote:
> On Tue, 23 Apr 2002, Larry McVoy wrote:
> > This one shows which directories had deltas over the specified time period.
> > Let me know if this is useful and/or if there should be a graphical barchart
> > of this sort of thing available.
> >
> > == Directory activity in the last week ==
> >    50  15.02%  include/asm-x86_64
> 
> It's a nice statistic and although I'm not sure whether there are "real"
> uses of it I'm wondering about what you are counting:
> 
> a) changesets (each changeset that touch file(s) below a directory)
> b) number of changed files (files touched by one or more changesets)
> c) each change to one file is counted

(c) each change to each file is counted.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVBJUDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVBJUDp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 15:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVBJUDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 15:03:45 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:28601 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S261614AbVBJUDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 15:03:13 -0500
Date: Thu, 10 Feb 2005 21:03:00 +0100
From: David Weinehall <tao@debian.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jakob Oestergaard <jakob@unthought.net>, pageexec@freemail.hu,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: the "Turing Attack" (was: Sabotaged PaXtest)
Message-ID: <20050210200300.GE19998@khan.acc.umu.se>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Jakob Oestergaard <jakob@unthought.net>, pageexec@freemail.hu,
	linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>
References: <42080689.15768.1B0C5E5F@localhost> <42093CC7.5086.1FC83D3E@localhost> <20050208164815.GA9903@elte.hu> <20050208220851.GA23687@elte.hu> <20050210134314.GA4146@elte.hu> <20050210135845.GT347@unthought.net> <20050210152149.GA6697@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050210152149.GA6697@elte.hu>
User-Agent: Mutt/1.4.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2005 at 04:21:49PM +0100, Ingo Molnar wrote:
> 
> * Jakob Oestergaard <jakob@unthought.net> wrote:
> 
> > On Thu, Feb 10, 2005 at 02:43:14PM +0100, Ingo Molnar wrote:
> > > 
> > > * pageexec@freemail.hu <pageexec@freemail.hu> wrote:
> > > 
> > > > the bigger problem is however that you're once again fixing the
> > > > symptoms, instead of the underlying problem - not the correct
> > > > approach/mindset.
> > > 
> > > i'll change my approach/mindset when it is proven that "the underlying
> > > problem" can be solved. (in a deterministic fashion)
> > 
> > I know neither exec-shield nor PaX and therefore have no bias or
> > preference - I thought I should chirp in on your comment here Ingo...
> > 
> > ...
> > > PaX cannot be a 'little bit pregnant'. (you might argue that exec-shield
> > > is in the 6th month, but that does not change the fundamental
> > > end-result: a child will be born ;-)
> > 
> > Yes and no.  I would think that the chances of a child being born are
> > greater if the pregnancy has lasted successfully up until the 6th month,
> > compared to a first week pregnancy.
> > 
> > I assume you get my point  :)
> 
> the important point is: neither PaX nor exec-shield can claim _for sure_
> that no child will be born, and neither can claim virginity ;-)
> 
> [ but i guess there's a point where a bad analogy must stop ;) ]

Yeah, sex is *usually* a much more pleasant experience than having your
machine broken into, even if it results in a pregnancy. =)


Regards: David
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290914AbSASFqy>; Sat, 19 Jan 2002 00:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290915AbSASFqn>; Sat, 19 Jan 2002 00:46:43 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:1209 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S290914AbSASFq2>;
	Sat, 19 Jan 2002 00:46:28 -0500
Date: Sat, 19 Jan 2002 06:46:14 +0100
From: David Weinehall <tao@acc.umu.se>
To: David Luyer <david_luyer@pacific.net.au>
Cc: "'Oliver Xymoron'" <oxymoron@waste.org>, linux-kernel@vger.kernel.org
Subject: Re: vm philosophising
Message-ID: <20020119064613.C18492@khan.acc.umu.se>
In-Reply-To: <007601c1a0a4$9ddc5d70$46943ecb@pacific.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <007601c1a0a4$9ddc5d70$46943ecb@pacific.net.au>; from david_luyer@pacific.net.au on Sat, Jan 19, 2002 at 03:49:02PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2002 at 03:49:02PM +1100, David Luyer wrote:
> I wrote:
> > Alan Cox wrote:
> > > > There is another VM that has a property that people would like:
> > > > deterministically handling memory exhaustion. 
> > > > Unfortunately, that VM
> > > > probably can't co-exist with over-commit and the 
> > > > performance gains that
> > > > affords.
> > > 
> > > It can definitely co-exist. Overcommit control is just a 
> > > book keeping
> > > exercise on address space commits.
> 
> [...]
> 
> and the comment I somehow missed putting on the end:
> 
> If you want to philosophise about VM strategies, think of
> overcommit as "ethernet" and precommit as "token ring".

You mean, that while technically superior, precommit suffers from
a topological problem and the fact that a very expensive concentrator
is needed?! ;-)

Token Ring still lives in the spirit, though it's called FDDI
nowadays...


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </

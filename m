Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292593AbSBUAFn>; Wed, 20 Feb 2002 19:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291970AbSBUAFd>; Wed, 20 Feb 2002 19:05:33 -0500
Received: from bitmover.com ([192.132.92.2]:56789 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S292593AbSBUAFP>;
	Wed, 20 Feb 2002 19:05:15 -0500
Date: Wed, 20 Feb 2002 16:05:14 -0800
From: Larry McVoy <lm@bitmover.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, linux-kernel@vger.kernel.org
Subject: Re: socket API extensions workgroup at OpenGroup needs HELP
Message-ID: <20020220160514.T27423@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Alexander Viro <viro@math.psu.edu>,
	Jan Harkes <jaharkes@cs.cmu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20020220233307.GA9133@ravel.coda.cs.cmu.edu> <Pine.GSO.4.21.0202201854310.14928-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0202201854310.14928-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, Feb 20, 2002 at 07:00:08PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2002 at 07:00:08PM -0500, Alexander Viro wrote:
> 
> 
> On Wed, 20 Feb 2002, Jan Harkes wrote:
> 
> > On Wed, Feb 20, 2002 at 06:21:11PM -0500, Alexander Viro wrote:
> > > Is that, by any chance, the same crowd that stands behind DAFS?
> > > If it _is_ the same crowd - send them to hell, they are beyond hope.
> > 
> > I almost thought that was directed at me, as Coda is kind of like a
> > Distributed version of AFS.
> > 
> > phew, luckily DAFS it isn't related to AFS or Coda ;)
> 
> 	DAFS isn't a filesystem - it's software equivalent of Freddy Kruger:
> 85 madmen^Wcompanies, one naive nurse^Widea, nightmares-inflicting monster
> conceived as the result of weeks of clusterfuck...

Yeah.  No kidding.  Anyone who thinks this is a good idea really hasn't
thought about it clearly.  It's nice marketing, sounds good, and is
a crock.  If you want this sort of thing, that's what kiobufs are for,
and if kiobufs don't work right, that's a bug.  Phooey on hacks.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265065AbTFRDs2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 23:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265063AbTFRDs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 23:48:28 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:43956
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265065AbTFRDs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 23:48:27 -0400
Date: Wed, 18 Jun 2003 06:02:10 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Larry McVoy <lm@work.bitmover.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: SCM domains [was Re: Linux 2.5.71]
Message-ID: <20030618040210.GB31640@dualathlon.random>
References: <20030615002153.GA20896@work.bitmover.com> <bcneo1$osd$1@cesium.transmeta.com> <20030618013940.GA19176@work.bitmover.com> <3EEFC6A3.5010406@zytor.com> <20030618033816.GB6552@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030618033816.GB6552@work.bitmover.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 17, 2003 at 08:38:16PM -0700, Larry McVoy wrote:
> On Tue, Jun 17, 2003 at 06:55:47PM -0700, H. Peter Anvin wrote:
> > Larry McVoy wrote:
> > > 
> > > It seems to me that kernel.org is the right place but if hpa is too busy
> > > (which I understand and respect) then we need to come up with some sort of
> > > domain which is unused, simple, and memorable.  I'm aware of the levels of
> > > distrust people have for bitmover but we could pay for it and run the DNS
> > > servers and let some set of community agreed on people manage the DNS entries
> > > if that makes people feel safe.
> > > 
> > 
> > I have no problem setting up CNAMEs in kernel.org if people are OK with
> > it.  Setting up actual servers is another matter.
> 
> I think CNAMEs are all that we need now.  BitMover and Penguin Computing
> will host it for the time being and if we cross over to the dark side
> someone else can step forward and host it and all you need to do is redo
> the CNAMEs.  
> 
> We do need to advertise the "URLs" for the CVS tree and the SVN tree and 
> the BK trees as well I suppose.  Is that a Gooch/FAQ thing?  Richard, you
> still out there?

this sounds fine to me. especially I can't think of an easier name to
remeber than cvs.kernel.org/svn.kernel.org ;)

thanks for taking care of those bits too.

Andrea

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265724AbUGHBXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265724AbUGHBXd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 21:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265727AbUGHBXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 21:23:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32484 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265724AbUGHBXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 21:23:31 -0400
From: Daniel Phillips <phillips@redhat.com>
Organization: Red Hat
To: sdake@mvista.com
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Date: Wed, 7 Jul 2004 21:30:17 -0400
User-Agent: KMail/1.6.2
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
References: <200407051442.27397.phillips@redhat.com> <200407051629.54737.phillips@redhat.com> <1089240951.822.144.camel@persist.az.mvista.com>
In-Reply-To: <1089240951.822.144.camel@persist.az.mvista.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407072130.17798.phillips@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 July 2004 18:55, Steven Dake wrote:
> On Mon, 2004-07-05 at 13:29, Daniel Phillips wrote:
> > On Monday 05 July 2004 15:08, Chris Friesen wrote:
> > > For cluster membership, you might consider looking at the OpenAIS
> > > CLM portion.  It would be nice if this type of thing was unified
> > > across more than just filesystems.
> >
> > My own project is a block driver, that's not a filesystem, right?
> > Cluster membership services as implemented by Sistina are generic,
> > symmetric and (hopefully) raceless.  See:
> >  
> > http://www.usenix.org/publications/library/proceedings/als00/2000pa
> >pers/papers/full_papers/preslan/preslan.pdf

Whoops, I just noticed that that link is way wrong, I must have been 
asleep when I posted it.  This is the correct one:

   http://people.redhat.com/~teigland/sca.pdf

and

   http://sources.redhat.com/cluster/cman/

Not that the other isn't interesting, it's just a little dated and 
GFS-specific.

Regards,

Daniel

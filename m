Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266370AbUGESgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266370AbUGESgG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 14:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266379AbUGESgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 14:36:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61903 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266370AbUGESf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 14:35:56 -0400
From: Daniel Phillips <phillips@redhat.com>
Organization: Red Hat
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Date: Mon, 5 Jul 2004 14:42:27 -0400
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200407050209.29268.phillips@redhat.com> <20040705150951.GA18210@infradead.org>
In-Reply-To: <20040705150951.GA18210@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407051442.27397.phillips@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Monday 05 July 2004 11:09, Christoph Hellwig wrote:
> On Mon, Jul 05, 2004 at 02:09:29AM -0400, Daniel Phillips wrote:
> > Red Hat and (the former) Sistina Software are pleased to announce
> > that we will host a two day kickoff workshop on GFS and Cluster
> > Infrastructure in Minneapolis, July 29 and 30, not too long after
> > OLS. We call this the "Cluster Summit" because it goes well beyond
> > GFS, and is really about building a comprehensive cluster
> > infrastructure for Linux, which will hopefully be a reality by the
> > time Linux 2.8 arrives. If we want that, we have to start now, and
> > we have to work like fiends, time is short.  We offer as a starting
> > point, functional code for a half-dozen major, generic cluster
> > subsystems that Sistina has had under development for several
> > years.
>
> Don't you think it's a little too short-term?

Not really.  It's several months later than it should have been if 
anything.

> I'd rather see the 
> cluster software that could be merged mid-term on KS (and that seems
> to be only OCFS2 so far)

Don't you think we ought to take a look at how OCFS and GFS might share 
some of the same infrastructure, for example, the DLM and cluster 
membership services?

"Think twice, merge once"

Regards,

Daniel

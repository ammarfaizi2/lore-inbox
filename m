Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWFGHJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWFGHJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 03:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWFGHJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 03:09:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63397 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751076AbWFGHJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 03:09:56 -0400
Subject: Re: 2.6.18 -mm merge plans -- GFS
From: Steven Whitehouse <swhiteho@redhat.com>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: David Teigland <teigland@redhat.com>, davej@redhat.com,
       Patrick Caulfield <pcaulfie@redhat.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1149519691.3856.1002.camel@quoit.chygwyn.com>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <1149514730.30024.133.camel@pmac.infradead.org>
	 <1149519691.3856.1002.camel@quoit.chygwyn.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Wed, 07 Jun 2006 08:12:10 +0100
Message-Id: <1149664330.3856.1126.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[at the risk of appearing to be mad by replying to myself...]

On Mon, 2006-06-05 at 16:01 +0100, Steven Whitehouse wrote:
> Hi,
> 
> On Mon, 2006-06-05 at 14:38 +0100, David Woodhouse wrote:
> > On Sun, 2006-06-04 at 13:50 -0700, Andrew Morton wrote:
> > > It's time to take a look at the -mm queue for 2.6.18.
> > 
> > You didn't mention GFS2 either -- is that ready to go upstream?
> 
> Assuming that 2.6.18 is imminent, as I understand it is, then my
> preferred option would be for GFS2 to spend one more cycle in -mm,
> assuming that nobody would disagree with that. I pretty sure that we'll
> be ready by the time 2.6.19 comes around to request inclusion upstream
> but 2.6.18 might be just a bit too soon,
> 
> Steve.
> 

To clarify the above a bit more, there is one regression in GFS2 in the
current -mm tree that needs to be fixed. Since Linus has announced
2.6.17-rc6, there is now in fact time for that to happen, so that we
will be ready to merge for 2.6.18. Sorry for any confusion my earlier
comment might have caused,

Steve.
[now recovered from jet lag :-) ]


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264781AbUD2VO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264781AbUD2VO3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 17:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264751AbUD2VLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 17:11:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5522 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264867AbUD2VKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 17:10:24 -0400
Date: Thu, 29 Apr 2004 17:10:18 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Chris Wright <chrisw@osdl.org>
cc: Jesse Barnes <jbarnes@sgi.com>, <linux-kernel@vger.kernel.org>,
       Erik Jacobson <erikj@subway.americas.sgi.com>,
       Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [PATCH] Process Aggregates (PAGG) support for the 2.6 kernel
In-Reply-To: <20040426174102.S22989@build.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0404291708060.9152-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Apr 2004, Chris Wright wrote:

> > Quite possibly.  Do you have a pointer to the latest bits/design docs?
> 
> Nothing aside from what's on ckrm.sf.net.  I know they've been retooling
> it a bit, but I'm not up on the current status.

Shailabh posted the latest CKRM code to lkml yesterday.

CKRM + rcfs seems to be slightly more capable than the PAGG code;
furthermore, CKRM already has a number of resource controller
modules while I'm only seeing very basic PAGG infrastructure.

Now would be a good time to join forces...

I admit that the CKRM project so far seems to have been mostly
an IBM internal project, but since there is community interest
it'd be time to get the community involved.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbTIYE3e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 00:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbTIYE3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 00:29:34 -0400
Received: from hockin.org ([66.35.79.110]:20230 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S261703AbTIYE3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 00:29:33 -0400
Date: Wed, 24 Sep 2003 21:14:17 -0700
From: Tim Hockin <thockin@hockin.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: akpm@zip.com.au, neilb@cse.unsw.edu.au, braam@clusterfs.com,
       davem@redhat.com, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       David Mosberger-Tang <davidm@hpl.hp.com>, tridge@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl-controlled number of groups.
Message-ID: <20030924211417.A16753@hockin.org>
References: <20030925035943.AE41C2C04B@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030925035943.AE41C2C04B@lists.samba.org>; from rusty@rustcorp.com.au on Thu, Sep 25, 2003 at 01:21:01PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 01:21:01PM +1000, Rusty Russell wrote:
> We have a client (using SAMBA) who has people in 190 groups.  Since NT
> has hierarchical groups, this is not all that rare.
> 
> What do people think of this patch?


Excuse me but JESUS FUCKING CHRIST.  I've been sending that patch since last
year.  when I get in the office tomorrow, I'll look at this further, and
compare it to mine.  check list archives - my most recent retry was a few
months back, but it was done.  No sysctl - I didn't think it was needed at
all.



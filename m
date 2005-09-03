Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161171AbVICGrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161171AbVICGrF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 02:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161169AbVICGrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 02:47:04 -0400
Received: from rgminet03.oracle.com ([148.87.122.32]:28768 "EHLO
	rgminet03.oracle.com") by vger.kernel.org with ESMTP
	id S1161168AbVICGrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 02:47:02 -0400
Date: Fri, 2 Sep 2005 23:46:34 -0700
From: Wim Coekaerts <wim.coekaerts@oracle.com>
To: linux clustering <linux-cluster@redhat.com>
Cc: Mark Fasheh <mark.fasheh@oracle.com>, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Message-ID: <20050903064633.GB4593@ca-server1.us.oracle.com>
References: <20050901104620.GA22482@redhat.com> <p73fysnqiej.fsf@verdi.suse.de> <20050903001628.GH21228@ca-server1.us.oracle.com> <200509030242.36506.phillips@istop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509030242.36506.phillips@istop.com>
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2005 at 02:42:36AM -0400, Daniel Phillips wrote:
> On Friday 02 September 2005 20:16, Mark Fasheh wrote:
> > As far as userspace dlm apis go, dlmfs already abstracts away a large part
> > of the dlm interaction...
> 
> Dumb question, why can't you use sysfs for this instead of rolling your own?

because it's totally different. have a look at what it does.


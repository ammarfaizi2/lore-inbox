Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbUBZQwL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 11:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262855AbUBZQvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 11:51:43 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:60034 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262848AbUBZQvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 11:51:41 -0500
Date: Thu, 26 Feb 2004 11:51:27 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Timothy Miller <miller@techsource.com>
cc: Peter Williams <peterw@aurema.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
In-Reply-To: <403E1A11.5050704@techsource.com>
Message-ID: <Pine.LNX.4.44.0402261150590.5629-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Feb 2004, Timothy Miller wrote:

> We don't want user-space programs to have control over priority.  This
> is DoS waiting to happen.

Nope, there's a solution to this.  Please read the CKRM
design draft I just posted elsewhere in this thread ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


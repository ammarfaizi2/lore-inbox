Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266409AbUBFEPI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 23:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266416AbUBFEPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 23:15:08 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:13009 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S266409AbUBFEPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 23:15:05 -0500
Date: Thu, 5 Feb 2004 23:15:00 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Jamie Lokier <jamie@shareable.org>, Andi Kleen <ak@suse.de>,
       <johnstul@us.ibm.com>, <drepper@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
In-Reply-To: <20040205214348.GK31926@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0402052314360.5933-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Feb 2004, Andrea Arcangeli wrote:

> However I'm unsure if you want all applications to be relocated
> ranodmly, and in turn if you want the vsyscalls relocated for all apps,
> exactly because this carry a cost. I think it should be optional.

If you think extra security should be optional, please don't
argue against it completely.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbUDAXIp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 18:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbUDAXIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 18:08:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14475 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262260AbUDAXIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 18:08:43 -0500
Date: Thu, 1 Apr 2004 18:08:18 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <kenneth.w.chen@intel.com>
Subject: Re: disable-cap-mlock
In-Reply-To: <20040401223619.GB18585@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0404011807350.5589-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Apr 2004, Andrea Arcangeli wrote:

> Marc-Christian extracted it and he posted it on l-k some week ago, so
> you can just check l-k (From: Marc-Christian) and you'll find it. It's
> against 2.4 however. Problem is that it's absolutely useless for the
> problem I had to solve, or I would be using it already instead.

Oracle seems to be using it just fine in a certain 2.4
based kernel, so why exactly do you think it would be
useless for the problem you want to solve ?

Also, what would need to be fixed in order for it to
not be useless ? ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265102AbUEYT5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265102AbUEYT5H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 15:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265087AbUEYTyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 15:54:02 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37030 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265080AbUEYTuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 15:50:37 -0400
Date: Tue, 25 May 2004 15:50:23 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Phy Prabab <phyprabab@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 4g/4g for 2.6.6
In-Reply-To: <20040525194115.GE29378@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0405251549530.26157-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2004, Andrea Arcangeli wrote:

> Clearly by opening enough files or enough network sockets or enough vmas
> or similar, you can still run out of normal zone, even on a 2G system,
> but this is not the point or you would be shipping 4:4 on the 2G systems
> too, no?

The point is, people like to run bigger workloads on
bigger systems. Otherwise they wouldn't bother buying
those bigger systems.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


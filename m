Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbTJAX2h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 19:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbTJAX2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 19:28:37 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:1972 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262730AbTJAX2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 19:28:35 -0400
Date: Wed, 1 Oct 2003 19:28:27 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Chris Wright <chrisw@osdl.org>, James Morris <jmorris@redhat.com>,
       <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
       <vserver@solucorp.qc.ca>
Subject: Re: sys_vserver
In-Reply-To: <Pine.LNX.4.44.0310011620440.6077-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0310011928000.4454-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Oct 2003, Linus Torvalds wrote:

> And I suspect you'll find a number of vendors who start integrating
> patches into their "server release" thing if there truly is enough
> pressure from users. Which is fine.

Actual use will also help determine exactly what functionality
should be merged into 2.7 and what wasn't really needed.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


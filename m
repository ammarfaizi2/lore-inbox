Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbUK3SKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbUK3SKp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 13:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbUK3SGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 13:06:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7868 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262238AbUK3SEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 13:04:31 -0500
Date: Tue, 30 Nov 2004 13:04:22 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
cc: linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk, akpm@osdl.org
Subject: Re: Xen VMM patch set - take 3
In-Reply-To: <E1CYxMo-0005GB-00@mta1.cl.cam.ac.uk>
Message-ID: <Pine.LNX.4.61.0411301302460.21172@chimarrao.boston.redhat.com>
References: <E1CYxMo-0005GB-00@mta1.cl.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2004, Ian Pratt wrote:

> We didn't get much feedback from take 2, so hopefully we're
> converging on something that's acceptable.

I see it's all been cleaned up, it all looks good to me.

> The only major difference between this set and the previous is the way 
> we handle the /dev/mem changes. I think the new approach is rather 
> cleaner.

Yay.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

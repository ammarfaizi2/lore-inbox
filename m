Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265228AbUD3PXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265228AbUD3PXI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 11:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbUD3PXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 11:23:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11733 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265228AbUD3PXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 11:23:06 -0400
Date: Fri, 30 Apr 2004 11:22:49 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Christoph Hellwig <hch@infradead.org>
cc: Erik Jacobson <erikj@subway.americas.sgi.com>, Paul Jackson <pj@sgi.com>,
       <chrisw@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Process Aggregates (PAGG) support for the 2.6 kernel
In-Reply-To: <20040430140611.A11636@infradead.org>
Message-ID: <Pine.LNX.4.44.0404301122200.6976-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2004, Christoph Hellwig wrote:

> Again, pagg doesn't even play in that league.  It's really just a tiny
> meachnism to allow a kernel module keep per-process data.  Policies like
> process-groups can be implemented on top of that.

So basically you're arguing that PAGG is better because it
doesn't do what's needed ? ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263341AbTI2NUY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 09:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263342AbTI2NUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 09:20:24 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:57003 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S263341AbTI2NUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 09:20:21 -0400
Date: Mon, 29 Sep 2003 09:20:12 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: John Bradford <john@grabjohn.com>
cc: Rob Landley <rob@landley.net>, Larry McVoy <lm@bitmover.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: log-buf-len dynamic
In-Reply-To: <200309291124.h8TBOlam000872@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.44.0309290919200.5758-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Sep 2003, John Bradford wrote:

> 'Enhanced' is, of course, a complete understatement.  What I am
> suggesting is basicaly adding A.I. functionality to diff and patch, to
> the point where they can merge three pieces of C code as efficiently
> as a good developer can.

In short, you want to implement the "graduate student
algorithm" in software ?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


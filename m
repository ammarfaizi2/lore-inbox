Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268866AbUHZNxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268866AbUHZNxL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 09:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268674AbUHZNxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 09:53:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43918 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268378AbUHZNxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 09:53:05 -0400
Date: Thu, 26 Aug 2004 09:52:49 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Christophe Saout <christophe@saout.de>
cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@osdl.org>,
       Hans Reiser <reiser@namesys.com>, <linux-fsdevel@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <flx@namesys.com>, <torvalds@osdl.org>,
       <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins (was: silent semantic changes with reiser4)
In-Reply-To: <1093527307.11694.23.camel@leto.cs.pocnet.net>
Message-ID: <Pine.LNX.4.44.0408260952230.26316-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004, Christophe Saout wrote:

> That's your opinion. reiser4 seems to work very well.

Have you tried /bin/cp, or a backup+restore ?

What happened to your file streams ?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268820AbUHZNai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268820AbUHZNai (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 09:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268948AbUHZNaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 09:30:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29312 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268820AbUHZN2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 09:28:01 -0400
Date: Thu, 26 Aug 2004 09:27:52 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Hans Reiser <reiser@namesys.com>
cc: Jeremy Allison <jra@samba.org>, Christoph Hellwig <hch@lst.de>,
       <akpm@osdl.org>, <linux-fsdevel@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <412DA26C.5060604@namesys.com>
Message-ID: <Pine.LNX.4.44.0408260927100.26316-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004, Hans Reiser wrote:

> I agree that your work is important without agreeing that MS client 
> domination will last.;-)  It is indeed my desire to give you every 
> single feature you need to emulate MS streams within files, but doing it 
> using directories that are files.  I would like to support you in 
> emulating windows faster than windows.

1) how do you back up and restore files with streams inside ?

2) how do standard unix utilities handle them ?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268996AbUHZODq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268996AbUHZODq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 10:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268995AbUHZODM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 10:03:12 -0400
Received: from cantor.suse.de ([195.135.220.2]:59364 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268959AbUHZOBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 10:01:01 -0400
Subject: Re: reiser4 plugins (was: silent semantic changes with reiser4)
From: Chris Mason <mason@suse.com>
To: Rik van Riel <riel@redhat.com>
Cc: Christophe Saout <christophe@saout.de>, Christoph Hellwig <hch@lst.de>,
       Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
In-Reply-To: <Pine.LNX.4.44.0408260952230.26316-100000@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.44.0408260952230.26316-100000@chimarrao.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1093528680.21878.284.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 26 Aug 2004 09:58:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-26 at 09:52, Rik van Riel wrote:
> On Thu, 26 Aug 2004, Christophe Saout wrote:
> 
> > That's your opinion. reiser4 seems to work very well.
> 
> Have you tried /bin/cp, or a backup+restore ?
> 
> What happened to your file streams ?

Shrug, backup programs can be fixed.  The fact that we couldn't backup
16GB files before O_LARGEFILE wasn't a reason not to do it.

IMHO it's more important to ask the question 'is this important for
linux' and then we can figure out how to make it work.

-chris



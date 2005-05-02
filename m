Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVEBQh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVEBQh2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 12:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbVEBQdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 12:33:46 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:63189 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261471AbVEBQcG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 12:32:06 -0400
Date: Mon, 2 May 2005 09:32:07 -0700
From: Tony Lindgren <tony@atomide.com>
To: linus@atomide.com, Andrew Morton <akpm@osdl.org>,
       Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Trying to coordinate moving subprojects to git
Message-ID: <20050502163206.GA16366@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Andrew & Len,

Here's a slightly modified repost of my earlier message
that got eaten by the mailing list filter :)

I'm trying to summarize some earlier dicussions on how to
coordinate moving BK projects over to git. This is probably
of interest to many other subprojects as well.

My main problem is where to host git trees for subprojects.

Here's how I see the move to git happening for various
subprojects:

- Somebody is rumored to offer a git project site soonish.[1]
  When that is available, subprojects can configure git
  trees there.
  
- Meanwhile, there should also be a BK repo for the latest
  kernel changes available soon.[2] Once that is available,
  it can be used for updating various trees.

Now I wonder if anybody has more news on the following:

- Who is working on setting a site available for git
  projects, and when is that site estimated to be available?
  
- Is anybody working on mirroring git changes in a BK tree?

I'm afraid I can't be much of help here setting up these sites
with my 128Kbps upstream speed...

Regards,

Tony

[1] http://lkml.org/lkml/2005/4/23/27
[1] http://lkml.org/lkml/2005/4/26/32

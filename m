Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWFTMKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWFTMKU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 08:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbWFTMKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 08:10:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23209 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932388AbWFTMKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 08:10:18 -0400
Subject: GFS2 and DLM
From: Steven Whitehouse <swhiteho@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Tue, 20 Jun 2006 13:17:13 +0100
Message-Id: <1150805833.3856.1356.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Linus, Andrew suggested to me to send this pull request to you directly.
Please consider merging the GFS2 filesystem and DLM from (they are both
in the same tree for ease of testing):

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-2.6.git

They have both lived in -mm for quite some time. We merged all review
feedback and patches that came though -mm and from the various previous
postings of patches to lkml and fsdevel mailing lists.

I have updated my git tree so that its fully uptodate with your current
tree (as of the time of this request) and tested building and using it,

Steve.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbVJNFgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbVJNFgs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 01:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbVJNFgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 01:36:48 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:23235 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932111AbVJNFgr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 01:36:47 -0400
Subject: Re: [PATCH 6/8] Fragmentation Avoidance V17:
	006_largealloc_tryharder
From: Dave Hansen <haveblue@us.ibm.com>
To: Joel Schopp <jschopp@austin.ibm.com>
Cc: Mel Gorman <mel@csn.ul.ie>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, lhms <lhms-devel@lists.sourceforge.net>
In-Reply-To: <434EB058.8090809@austin.ibm.com>
References: <20051011151221.16178.67130.sendpatchset@skynet.csn.ul.ie>
	 <20051011151251.16178.24064.sendpatchset@skynet.csn.ul.ie>
	 <434EB058.8090809@austin.ibm.com>
Content-Type: text/plain
Date: Thu, 13 Oct 2005 22:36:27 -0700
Message-Id: <1129268188.22903.34.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-13 at 14:07 -0500, Joel Schopp wrote:
> This is version 17, plus several versions I did while Mel was preoccupied with 
> his day job, makes well over 20 times this has been posted to the mailing lists 
> that are lkml, linux-mm, and memory hotplug.
> 
> All objections/feedback/suggestions that have been brought up on the lists are 
> fixed in the following version.  It's starting to become almost silent when a 
> new version gets posted, possibly because everybody accepts the code as perfect, 
> possibly because they have grown bored with it.  Probably a combination of both.

I don't think it's shown signs of stabilizing quite yet.  Each revision
has new code that needs to be cleaned up, and new obvious CodingStyle
issues.  Let's see a couple of incrementally cleaner releases go by,
which don't have renewed old issues, and then we can think about asking
to get it merged elsewhere.

-- Dave


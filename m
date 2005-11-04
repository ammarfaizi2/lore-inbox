Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbVKDSiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbVKDSiK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 13:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbVKDSiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 13:38:09 -0500
Received: from rgminet01.oracle.com ([148.87.122.30]:51168 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750819AbVKDSiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 13:38:08 -0500
Date: Fri, 4 Nov 2005 10:37:52 -0800
From: Wim Coekaerts <wim.coekaerts@oracle.com>
To: Zach Brown <zach.brown@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       mark.fasheh@oracle.com, Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [Patch] add AOP_TRUNCATED_PAGE, prepend AOP_ to WRITEPAGE_ACTIVATE
Message-ID: <20051104183752.GO29810@ca-server1.us.oracle.com>
References: <43667913.4030401@oracle.com> <20051103124536.0191bea6.akpm@osdl.org> <20051103074312.GQ11488@ca-server1.us.oracle.com> <20051103165306.GA4923@infradead.org> <20051103205802.31121fc4.akpm@osdl.org> <436BA907.9080604@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436BA907.9080604@oracle.com>
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Obviously, merging it into Linus's tree will fix up everyone's patching
> > problems, but it has no users at this time...
> 
> So, speaking of which, are there any barriers to merging OCFS2 now?  I think
> Christoph's concerns (silly /proc files, vma walking, endian stuff) have been
> addressed.

and context dependent symlinks are gone too ;) to please mighty Al :)


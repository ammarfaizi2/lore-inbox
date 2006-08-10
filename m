Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422669AbWHJRrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422669AbWHJRrP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 13:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422668AbWHJRrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 13:47:14 -0400
Received: from xenotime.net ([66.160.160.81]:35815 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1422664AbWHJRrM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 13:47:12 -0400
Date: Thu, 10 Aug 2006 10:49:54 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Alex Tomas <alex@clusterfs.com>
Cc: Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 1/9] extents for ext4
Message-Id: <20060810104954.0e03c83e.rdunlap@xenotime.net>
In-Reply-To: <m37j1hlyzv.fsf@bzzz.home.net>
References: <1155172827.3161.80.camel@localhost.localdomain>
	<20060809233940.50162afb.akpm@osdl.org>
	<m37j1hlyzv.fsf@bzzz.home.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 13:29:56 +0400 Alex Tomas wrote:

> >>>>> Andrew Morton (AM) writes:
> 
>  >> From a quick scan:
> 
>  AM> - The code is very poorly commented.  I'd want to spend a lot of time
>  AM>   reviewing this implementation, but not in its present state.  
> 
> what sort of comments are you expecting?

Helpful ones.  Not obvious stuff.  Intents.
Tricks used (if they are the right thing to do).

How, what, why.  But not nitty-gritty details of how.
"Why" is often more important.

>  AM> - The existing comments could benefit from some rework by a native English
>  AM>   speaker.
> 
> could someone assist here, please?

Yes.  How would you like it?  Just comments via email or (quilt) patches?
Which files/patches?

---
~Randy

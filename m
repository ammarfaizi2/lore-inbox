Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbVIVGgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbVIVGgJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 02:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbVIVGgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 02:36:08 -0400
Received: from rgminet03.oracle.com ([148.87.122.32]:32602 "EHLO
	rgminet03.oracle.com") by vger.kernel.org with ESMTP
	id S1750933AbVIVGgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 02:36:07 -0400
Date: Wed, 21 Sep 2005 23:35:57 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-mm1
Message-ID: <20050922063557.GH27375@ca-server1.us.oracle.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050921222839.76c53ba1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050921222839.76c53ba1.akpm@osdl.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 10:28:39PM -0700, Andrew Morton wrote:
>  git-ocfs2-prep.patch
>  git-ocfs2.patch

	As the truncate_inode_pages patch is now in Linus' git, it is
no longer in git-ocfs2.patch.  -rc2-mm1 is effectively reverting it.
git-ocfs2-prep.patch should be removed.

Joel


-- 

"There is no sincerer love than the love of food."  
         - George Bernard Shaw 

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

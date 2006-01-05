Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWAEBWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWAEBWY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 20:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWAEBWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 20:22:24 -0500
Received: from rgminet01.oracle.com ([148.87.122.30]:14740 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751113AbWAEBWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 20:22:23 -0500
Date: Wed, 4 Jan 2006 17:22:02 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Zach Brown <zach.brown@oracle.com>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Christoph Hellwig <hch@lst.de>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: merging ocfs2?
Message-ID: <20060105012202.GQ18439@ca-server1.us.oracle.com>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Zach Brown <zach.brown@oracle.com>, Andrew Morton <akpm@osdl.org>,
	Arjan van de Ven <arjan@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Wim Coekaerts <wim.coekaerts@oracle.com>,
	Mark Fasheh <mark.fasheh@oracle.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <43BAF93A.10509@oracle.com> <Pine.LNX.4.64.0601041649270.3668@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601041649270.3668@g5.osdl.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 04:50:49PM -0800, Linus Torvalds wrote:
> However, I really _really_ prefer that people who use git to merge use the 
> native git protocol, which I trust. That http: thing may work, but it's a 
> cludge ;)
> 
> Can you run git-daemon on the machine? 

	Getting that port open is in progress.  http: is the for-now
solution.

Joel

-- 

"Practice random acts of kindness and senseless acts of beauty."

 Oh, and don't forget where your towel is.

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127


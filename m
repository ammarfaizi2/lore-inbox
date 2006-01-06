Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752285AbWAFEid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285AbWAFEid (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 23:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752335AbWAFEid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 23:38:33 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:59550 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1752253AbWAFEic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 23:38:32 -0500
Date: Thu, 5 Jan 2006 20:38:05 -0800
From: Wim Coekaerts <wim.coekaerts@oracle.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Zach Brown <zach.brown@oracle.com>, Andrew Morton <akpm@osdl.org>,
       Joel Becker <Joel.Becker@oracle.com>, Christoph Hellwig <hch@lst.de>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: merging ocfs2?
Message-ID: <20060106043804.GC14715@ca-server1.us.oracle.com>
References: <43BAF93A.10509@oracle.com> <Pine.LNX.4.64.0601041649270.3668@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601041649270.3668@g5.osdl.org>
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 04:50:49PM -0800, Linus Torvalds wrote:
> On Tue, 3 Jan 2006, Zach Brown wrote:
> > Joel has done the heavy lifting to bring its git repository up to date
> > so one should be able to pull from:
> > 
> >   http://oss.oracle.com/git/ocfs2.git
> 
> If Christoph is happy with it, and there has been no grumbling from -mm, I 
> can certainly merge it.

Linus, the code has been carried in -mm since 2.6.12-rc4-mm1 and hch
just said he's fine with it - please merge when you can.

> However, I really _really_ prefer that people who use git to merge use the 
> native git protocol, which I trust. That http: thing may work, but it's a 
> cludge ;)
> 
> Can you run git-daemon on the machine? 

we will going forward - need to get some admins to do stuff, otherwise
if you want it from day 1 we can get it on kernel.org/git. but my guess
is that it will only be a little while and the first updates will come
through git-daemon (eg a week or so)

thanks
Wim


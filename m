Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWIXX3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWIXX3W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 19:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWIXX3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 19:29:22 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:1944 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750782AbWIXX3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 19:29:21 -0400
Date: Sun, 24 Sep 2006 16:28:54 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, ocfs2-devel@oss.oracle.com,
       linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>
Subject: Re: [git patches] ocfs2 post 2.6.18 features
Message-ID: <20060924232854.GG32106@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20060924221115.GF32106@ca-server1.us.oracle.com> <Pine.LNX.4.64.0609241532140.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609241532140.3952@g5.osdl.org>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2006 at 03:36:14PM -0700, Linus Torvalds wrote:
> 
> Ok, pulled, and pushed out.
Great, thanks!


> And btw, I appreciate how you separately explained the fs/namei.c change, 
> together with the diff for just that part. This is a prime example of how 
> to make things easier for me to verify, when I see something touching a 
> generic file. Thanks.
Oh, excellent - I'm glad that worked out. I asked Andrew a couple weeks back
how we should handle that patch, and he indicated that I could push it if I
clearly noted its existence in my e-mail.


> I do have a small nit: when you ask me to pull, you did:
> 
> > Please pull from 'upstream-linus' branch of
> > git://git.kernel.org/pub/scm/linux/kernel/git/mfasheh/ocfs2.git
> 
> I really prefer to see the branch-name at the end of the line (don't worry 
> if it's more than 80 characters), because that way I don't make the 
> mistake of cutting-and-pasting the git URL, and forgetting the branch.
No problem - script updated. I copied the format from one of Jeff's more
recent pull mails:

Please pull from 'upstream-linus' branch of
git://git.kernel.org/pub/scm/linux/kernel/git/mfasheh/ocfs2.git
upstream-linus

Hope that works for you.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com

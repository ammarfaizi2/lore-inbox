Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbVCJF4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVCJF4B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 00:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVCJFnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 00:43:45 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:43917 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261710AbVCJFjg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 00:39:36 -0500
Date: Thu, 10 Mar 2005 06:40:11 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Omkhar Arasaratnam <iamroot@ca.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, tgall@us.ibm.com,
       antonb@au1.ibm.com
Subject: Re: [BUG] 2.6.11- sym53c8xx Broken on pp64
Message-ID: <20050310054011.GA8287@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Omkhar Arasaratnam <iamroot@ca.ibm.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>, tgall@us.ibm.com,
	antonb@au1.ibm.com
References: <422FA817.4060400@ca.ibm.com> <1110420620.32525.145.camel@gaston> <Pine.LNX.4.58.0503091821570.2530@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503091821570.2530@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 06:25:56PM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 10 Mar 2005, Benjamin Herrenschmidt wrote:
> > 
> > BTW, Linus: Any chance you ever change something to version or
> > extraversion in bk just after a release ? I know I already ask and it
> > degenerated into a flamefest, and I don't know if that is specifically
> > the case now, but I keep getting report of people saying "I have a bug
> > in 2.6.xx" while in fact, they have some kind of bk clone of sometime
> > after 2.6.xx...
> 
> The answer is the same: I'd still like to have somebody (preferably Sam)  
> who is comfortable with all the build scripts get a revision-control-
> specific version at build-time, so that BK users would get the top-of-tree 
> key value, and other people could get some CVS revision or something.

I have a patch somewhere in my inbox, and got one from Ryan yesterday
also. I will see if I during the weekend find some time to look at it.

	Sam

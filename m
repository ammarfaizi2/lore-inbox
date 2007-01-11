Return-Path: <linux-kernel-owner+w=401wt.eu-S1030234AbXAKIpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbXAKIpu (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 03:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbXAKIpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 03:45:50 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3843 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030234AbXAKIpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 03:45:50 -0500
Date: Thu, 11 Jan 2007 09:45:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John McCutchan <john@johnmccutchan.com>, rml@novell.com
Subject: Re: 2.6.20-rc4: known unfixed regressions (v3)
Message-ID: <20070111084554.GF21724@stusta.de>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org> <20070111051022.GA21724@stusta.de> <45A5DCAB.6060900@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A5DCAB.6060900@yahoo.com.au>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2007 at 05:43:55PM +1100, Nick Piggin wrote:
> Adrian Bunk wrote:
> 
> >Subject    : BUG: at fs/inotify.c:172 set_dentry_child_flags()
> >References : http://bugzilla.kernel.org/show_bug.cgi?id=7785
> >Submitter  : Cijoml Cijomlovic Cijomlov <cijoml@volny.cz>
> >Handled-By : John McCutchan <john@johnmccutchan.com>
> >Status     : problem is being debugged
> 
> I'm not sure that this is actually a regression for 2.6.20-rc.

The submitter says it doesn't occur in 2.6.19.

> I'll see if I can cook up something that dumps a bit more info
> for us. There must be some peculiar usage pattern and/or filesystem
> involved.

Thanks.  :-)

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


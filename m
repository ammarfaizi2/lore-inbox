Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161047AbWFJXCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161047AbWFJXCD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 19:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161049AbWFJXCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 19:02:02 -0400
Received: from mail.gmx.net ([213.165.64.21]:10684 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161048AbWFJXCA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 19:02:00 -0400
X-Authenticated: #14349625
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Adrian Bunk <bunk@stusta.de>, Gerrit Huizenga <gh@us.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Alex Tomas <alex@clusterfs.com>,
       Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
In-Reply-To: <20060610144228.GA6416@elte.hu>
References: <Pine.LNX.4.64.0606090907060.5498@g5.osdl.org>
	 <E1FolFA-0007RU-Ab@w-gerrit.beaverton.ibm.com>
	 <20060610134645.GB11634@stusta.de>  <20060610144228.GA6416@elte.hu>
Content-Type: text/plain
Date: Sun, 11 Jun 2006 01:05:09 +0200
Message-Id: <1149980709.7627.15.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-10 at 16:42 +0200, Ingo Molnar wrote:
> frankly, i'll leave that decision to the ext3 developers and obviously, 
> to distributors. Their filesystem has handled my data for 10 years, and 
> they have been very conservative about their technical choices 
> throughout. I trust them to not mess up this time either.

That's my view in nut shell (minus distributors).  Add caps.

	-Mike 



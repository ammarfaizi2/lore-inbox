Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262560AbTCISOk>; Sun, 9 Mar 2003 13:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262561AbTCISOk>; Sun, 9 Mar 2003 13:14:40 -0500
Received: from c5-rba-136.absamail.co.za ([196.39.51.136]:56324 "EHLO
	mail.codefountain.com") by vger.kernel.org with ESMTP
	id <S262560AbTCISOk>; Sun, 9 Mar 2003 13:14:40 -0500
Date: Sun, 9 Mar 2003 20:28:57 +0200
From: Craig Schlenter <craig.schlenter@absamail.co.za>
To: linux-kernel@vger.kernel.org
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, CaT <cat@zip.com.au>
Subject: Re: Kernel bug in dcache.h:266; 2.5.64, EIP at sysfs_remove_dir
Message-ID: <20030309182857.GA11703@codefountain.com>
References: <20030306192050.GA1414@irc.pl> <14500000.1047231917@[10.10.2.4]> <20030309180732.GA11612@codefountain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030309180732.GA11612@codefountain.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 09, 2003 at 08:07:32PM +0200, Craig Schlenter wrote:
> On Sun, Mar 09, 2003 at 09:45:30AM -0800, Martin J. Bligh wrote:
> > Look for akpm's latest -mm tree release notes - the patch is embedded
> > in there.
> 
> [I posted a similar oops in another thread]
> 
> Dang! I glossed over that as the comment mentioned SMP and PREEMPT
> and I'm running on uniprocessor. Thanks for the pointer. Will try
> it out shortly ...

Replying to myself :)

The patch was already part of my tree as I had grabbed the latest
bk stuff from v2.5/testing/cset which means my oops is still unresolved.

I see there is a another oops that looks very much that same that
was posted by CaT <cat@zip.com.au> .. CC'ed in case the above notes
help.

Cheers,

--Craig

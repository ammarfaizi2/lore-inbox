Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261406AbTCGH3h>; Fri, 7 Mar 2003 02:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261413AbTCGH3h>; Fri, 7 Mar 2003 02:29:37 -0500
Received: from [196.41.29.142] ([196.41.29.142]:18930 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id <S261406AbTCGH3g>; Fri, 7 Mar 2003 02:29:36 -0500
Subject: Re: Corruption problem with ext3 and htree
From: Martin Schlemmer <azarah@gentoo.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030306234819.Q1373@schatzie.adilger.int>
References: <20030307063940.6d81780e.azarah@gentoo.org>
	 <20030306234819.Q1373@schatzie.adilger.int>
Content-Type: text/plain
Organization: 
Message-Id: <1047022581.22533.111.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2- 
Date: 07 Mar 2003 09:38:01 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-07 at 08:48, Andreas Dilger wrote:
> On Mar 07, 2003  06:39 +0200, Martin Schlemmer wrote:
> > For some time now I have been having a problem with ext3 and htree.
> > 
> > I use Gentoo, with portage as package system.  My root is on ext3
> > without htree, and my portage tmp/build directory is on another
> > drive with ext3 and htree.
> > 
> > Now, when you install something, it unpacks and compile and then
> > install it to the build root on the tmp partition (ext3 with htree),
> > and then 'merge' it to / (ext3 without htree) from that build root.
> 
> There have been a number of ext3+htree fixes in the last week or so.
> I'm not sure if all of them are in the kernel yet, but I think the -mm
> tree will have the majority of them.  Please also see the ext2-devel
> and ext3-users mailing list archives for the last week for the patches.
> 

Thanks, will have a try tonight and let you know.


Regards,

-- 
Martin Schlemmer
Gentoo Linux Developer, Desktop Team
Cape Town, South Africa


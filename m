Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWFIUbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWFIUbg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWFIUbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:31:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45999 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932264AbWFIUbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:31:34 -0400
Date: Fri, 9 Jun 2006 13:31:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andreas Dilger <adilger@clusterfs.com>
cc: Alex Tomas <alex@clusterfs.com>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
In-Reply-To: <20060609201643.GG5964@schatzie.adilger.int>
Message-ID: <Pine.LNX.4.64.0606091330310.5498@g5.osdl.org>
References: <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
 <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net>
 <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
 <20060609181020.GB5964@schatzie.adilger.int> <Pine.LNX.4.64.0606091114270.5498@g5.osdl.org>
 <m31wty9o77.fsf@bzzz.home.net> <Pine.LNX.4.64.0606091137340.5498@g5.osdl.org>
 <20060609201643.GG5964@schatzie.adilger.int>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Jun 2006, Andreas Dilger wrote:
> 
> It's funny that everyone is arguing to fork ext3 into ext4, for a feature
> that will primarily allow it to work with large disks (that are already
> here, not some wacky pipe dream of featuritis as Jeff thinks).  Yet the
> same people that are advocating code duplication on a massive scale in
> ext4 are against 5 lines of duplication between the VFS and a filesystem,
> or in a couple of drivers here and there.

You haven't actually listened to any of the arguments, have you?

Please remove me from the Cc on this thread. I'm not interested. 

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbTJESQq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 14:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263301AbTJESQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 14:16:46 -0400
Received: from tartutest.cyber.ee ([193.40.6.70]:48904 "EHLO
	tartutest.cyber.ee") by vger.kernel.org with ESMTP id S263012AbTJESQp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 14:16:45 -0400
From: Meelis Roos <mroos@linux.ee>
To: john@deater.net, linux-kernel@vger.kernel.org
Subject: Re: gcc-3.3 patch..
In-Reply-To: <Pine.LNX.4.58.0310030034140.21840@pianoman.cluster.toy>
User-Agent: tin/1.7.1-20030907 ("Sandray") (UNIX) (Linux/2.4.23-pre5 (i686))
Message-Id: <E1A6DQt-0008Hw-7J@rhn.tartu-labor>
Date: Sun, 05 Oct 2003 21:16:39 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JC> I believe someone else(? apologies, i -really- haven't followed
JC> sparc-linux since then) was fixing these things in a different way....?
JC> maybe they just got lost in the queue or someone else had a better way of
JC> doing them?  I know there have been changes to checksum.h since then, so
JC> it's not surprising the patch doesn't apply cleanly.  If the issue is
JC> still there in 2.4 it should be easy to look at the patch and apply it
JC> manually.

It was me. I have not had success so far, 2.4.23-pre5 with my asm
constraint modifications to include/asm-sparc/checksum.h hangs apt-get
in wait_for_page.

If you have a working patch, would you please repost it since I was also
out of sparclinux list and just today set up my mail2news again.

-- 
Meelis Roos (mroos@linux.ee)

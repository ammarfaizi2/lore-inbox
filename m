Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbUDPUZh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 16:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbUDPUZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 16:25:36 -0400
Received: from ns.suse.de ([195.135.220.2]:6043 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263719AbUDPUZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 16:25:24 -0400
Subject: Re: [PATCH] reiserfs v3 fixes and features
From: Chris Mason <mason@suse.com>
To: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
In-Reply-To: <200404162206.50654@WOLK>
References: <1081274618.30828.30.camel@watt.suse.com>
	 <1082141666.27614.1448.camel@watt.suse.com> <200404162147.16846@WOLK>
	 <200404162206.50654@WOLK>
Content-Type: text/plain
Message-Id: <1082147216.27614.1459.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 16 Apr 2004 16:26:57 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-16 at 16:06, Marc-Christian Petersen wrote:
> On Friday 16 April 2004 21:47, Marc-Christian Petersen wrote:
> 
> Hi again,
> 
> > > ftp.suse.com/pub/people/mason/patches/reiserfs/2.6.5-mm6
> > > Only reiserfs-group-alloc-9 has changed.
> 
> > hmm, does not apply to 2.6.5-mm6 (applied all from series.mm) before for
> > sure.
> 
> Somewhen in the near future I'll forget my name ;(

I just downloaded things to double check and it still works for me. 
But, that ftp directory had an added bonus file in it 2.6.5-mm6.bz2,
which was incomplete.  I've deleted it, make sure you aren't patching
based on that.

-chris



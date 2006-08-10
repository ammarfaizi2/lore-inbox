Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWHJTEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWHJTEA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWHJTEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:04:00 -0400
Received: from [80.71.248.82] ([80.71.248.82]:28825 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S932309AbWHJTD7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:03:59 -0400
X-Comment-To: "Randy.Dunlap"
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 1/9] extents for ext4
References: <1155172827.3161.80.camel@localhost.localdomain>
	<20060809233940.50162afb.akpm@osdl.org> <m37j1hlyzv.fsf@bzzz.home.net>
	<20060810104954.0e03c83e.rdunlap@xenotime.net>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Thu, 10 Aug 2006 23:05:14 +0400
In-Reply-To: <20060810104954.0e03c83e.rdunlap@xenotime.net> (Randy Dunlap's message of "Thu, 10 Aug 2006 10:49:54 -0700")
Message-ID: <m3mzacl8d1.fsf@bzzz.home.net>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Randy Dunlap (RD) writes:

 RD> On Thu, 10 Aug 2006 13:29:56 +0400 Alex Tomas wrote:
 >> >>>>> Andrew Morton (AM) writes:
 >> 
 >> >> From a quick scan:
 >> 
 AM> - The code is very poorly commented.  I'd want to spend a lot of time
 AM> reviewing this implementation, but not in its present state.  
 >> 
 >> what sort of comments are you expecting?

 RD> Helpful ones.  Not obvious stuff.  Intents.
 RD> Tricks used (if they are the right thing to do).

 RD> How, what, why.  But not nitty-gritty details of how.
 RD> "Why" is often more important.

well, it's a simple b+tree and i'm not sure there are ticks in.
I'll try to re-read them again WRT what you wrote.


 AM> - The existing comments could benefit from some rework by a native English
 AM> speaker.
 >> 
 >> could someone assist here, please?

 RD> Yes.  How would you like it?  Just comments via email or (quilt) patches?
 RD> Which files/patches?

please, have a look at ext4-extents.patch first

thanks, Alex

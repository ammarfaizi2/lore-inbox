Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269014AbUHZOxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269014AbUHZOxb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 10:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269019AbUHZOud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 10:50:33 -0400
Received: from gate.in-addr.de ([212.8.193.158]:59799 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S268961AbUHZOt2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 10:49:28 -0400
Date: Thu, 26 Aug 2004 16:46:06 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Hans Reiser <reiser@namesys.com>, Rik van Riel <riel@redhat.com>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826144606.GM3125@marowsky-bree.de>
References: <Pine.LNX.4.44.0408252052420.13240-100000@chimarrao.boston.redhat.com> <412DA1FD.4010507@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <412DA1FD.4010507@namesys.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-08-26T01:40:29,
   Hans Reiser <reiser@namesys.com> said:

> >Obviously this is something that needs to be sorted out at
> >the VFS layer.
> >
> It needs to be sorted out, whether it is sorted out at the VFS layer is 
> unimportant.

So what exactly is wrong with sorting it out at the VFS layer, and why
do you _insist_ on sorting it in the reiserfs4 core? I'm missing
something, please fill me in on the details.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	   \\\  /// 
SUSE Labs, Research and Development \honk/ 
SUSE LINUX AG - A Novell company     \\// 


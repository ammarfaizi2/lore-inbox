Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265187AbSJaDzI>; Wed, 30 Oct 2002 22:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265189AbSJaDzI>; Wed, 30 Oct 2002 22:55:08 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:63481 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S265187AbSJaDzH>; Wed, 30 Oct 2002 22:55:07 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 30 Oct 2002 20:59:02 -0700
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: What's left over.
Message-ID: <20021031035902.GD28982@clusterfs.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
References: <20021031020836.E576E2C09F@lists.samba.org> <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 30, 2002  18:31 -0800, Linus Torvalds wrote:
> On Thu, 31 Oct 2002, Rusty Russell wrote:
> > ext2/ext3 ACLs and Extended Attributes
> 
> I don't know why people still want ACL's. There were noises about them for 
> samba, but I've not heard anything since. Are vendors using this?

I don't really care about ACLs so much one way or the other, but we
DEFINITELY use EAs with Lustre, so at the minimum if we could have
that part of the changes I'd be happy.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWGXOs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWGXOs5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 10:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWGXOs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 10:48:57 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:10648 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932198AbWGXOs4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 10:48:56 -0400
Subject: Re: [PATCH 3/4] fs: Removing useless casts
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: takis@issaris.org
Cc: linux-kernel@vger.kernel.org, jaharkes@cs.cmu.edu, coda@cs.cmu.edu,
       codalist@TELEMANN.coda.cs.cmu.edu, ext2-devel@lists.sourceforge.net,
       sct@redhat.com, akpm@osdl.org, adilger@clusterfs.com,
       mikulas@artax.karlin.mff.cuni.cz, jffs-dev@axis.com,
       jfs-discussion@lists.sourceforge.net, vandrove@vc.cvut.cz,
       linware@sh.cvut.cz, trond.myklebust@fys.uio.no, aia21@cantab.net,
       linux-ntfs-dev@lists.sourceforge.net, xfs-masters@oss.sgi.com,
       nathans@sgi.com, xfs@oss.sgi.com, neilb@cse.unsw.edu.au,
       nfs@lists.sourceforge.net
In-Reply-To: <20060721140637.GC27097@issaris.org>
References: <20060721140637.GC27097@issaris.org>
Content-Type: text/plain
Date: Mon, 24 Jul 2006 09:48:51 -0500
Message-Id: <1153752531.10822.8.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-21 at 16:06 +0200, takis@issaris.org wrote:
> From: Panagiotis Issaris <takis@issaris.org>
> 
> * Removing useless casts
> * Removing useless wrapper
> * Conversion from kmalloc+memset to kzalloc
> 
> Signed-off-by: Panagiotis Issaris <takis@issaris.org> 

Acked-by: Dave Kleikamp <shaggy@austin.ibm.com>

The jfs bit is okay.

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316342AbSHBSQ4>; Fri, 2 Aug 2002 14:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316390AbSHBSQ4>; Fri, 2 Aug 2002 14:16:56 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:64505 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S316342AbSHBSQz>; Fri, 2 Aug 2002 14:16:55 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 2 Aug 2002 12:18:37 -0600
To: Salvador Peralta <speralta@willamette.edu>
Cc: linux-kernel@vger.kernel.org, bhcompile@daffy.perf.redhat.com,
       mspalti@willamette.edu
Subject: Re: Problem: Assertion Failure in journal_commit_transaction
Message-ID: <20020802181837.GJ29562@clusterfs.com>
Mail-Followup-To: Salvador Peralta <speralta@willamette.edu>,
	linux-kernel@vger.kernel.org, bhcompile@daffy.perf.redhat.com,
	mspalti@willamette.edu
References: <3D4ACB04.5080102@willamette.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D4ACB04.5080102@willamette.edu>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 02, 2002  11:10 -0700, Salvador Peralta wrote:
> 1:  Assertion Failure in journal_commit_transaction
> 2:  8:02 AM PST, system lost all console and network i/o.  Error message 
> on console included:  Assertion Failure in journal_commit_transaction
> buffer_jdirty(bh).
> 3:  kernel
> 4:  Linux version 2.4.18-3smp (bhcompile@daffy.perf.redhat.com) (gcc 
> version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #1 SMP Thu Apr 18 
> 07:27:31 EDT 2002

Fixed in 2.4.18-4smp and later.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/


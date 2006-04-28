Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030335AbWD1J05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbWD1J05 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 05:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbWD1J05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 05:26:57 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:19140 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1030335AbWD1J04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 05:26:56 -0400
To: adilger@clusterfs.com
Cc: tytso@mit.edu, sct@redhat.com, Ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re:[Ext2-devel] [RFC][10/21]ext3 enlarge blocksize
Message-Id: <20060428182647sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Fri, 28 Apr 2006 18:26:46 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your advice, Andreas

> I like this patch, but prefer if we maintain as much compatibility as
> possible.  There is not really a reason to make a filesystem 
> incompatible
> unless there are actually files > 2TB stored in it (just like 
> we didn't
> make filesystems incompatible for large_file unless there 
> were files over
> 2GB in the filesystem).
 
I agree your opinion.  I'll consider deeply what to do to maintain as
much compatibility as possible, based on your comment.

BTW, I'll take nine days vacation on the next week and restart this
work after that.

Cheers, sho

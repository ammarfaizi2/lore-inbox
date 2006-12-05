Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968644AbWLETS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968644AbWLETS3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 14:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968646AbWLETS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 14:18:29 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:54598 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968645AbWLETS2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 14:18:28 -0500
Date: Tue, 5 Dec 2006 14:18:24 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -mm merge plans for 2.6.20
Message-ID: <20061205191824.GB2240@filer.fsl.cs.sunysb.edu>
References: <20061204204024.2401148d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061204204024.2401148d.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 08:40:24PM -0800, Andrew Morton wrote:
... 
> fsstack-introduce-fsstack_copy_attrinode_.patch
> fsstack-introduce-fsstack_copy_attrinode_-tidy.patch
> fsstack-introduce-fsstack_copy_attrinode_-fs-stackc-should-include-linux-fs_stackh.patch
> ecryptfs-use-fsstacks-generic-copy-inode-attr.patch
> ecryptfs-use-fsstacks-generic-copy-inode-attr-tidy-fix.patch
> ecryptfs-use-fsstacks-generic-copy-inode-attr-tidy-fix-fix.patch
> struct-path-rename-reiserfss-struct-path.patch
> struct-path-rename-dms-struct-path.patch
> struct-path-move-struct-path-from-fs-nameic-into.patch
> struct-path-make-ecryptfs-a-user-of-struct-path.patch
> vfs-change-struct-file-to-use-struct-path.patch
...
> 
>  Shall merge.  I guess.  Doesn't seem very useful.

I have two more fixes for fsstack/ecryptfs. I'll send them as a reply to
this email...

Josef "Jeff" Sipek.

-- 
FORTUNE PROVIDES QUESTIONS FOR THE GREAT ANSWERS: #19
A:      To be or not to be.
Q:      What is the square root of 4b^2?

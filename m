Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVCYRUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVCYRUS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 12:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbVCYRUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 12:20:18 -0500
Received: from mail.dif.dk ([193.138.115.101]:1436 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261684AbVCYRUN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 12:20:13 -0500
Date: Fri, 25 Mar 2005 18:22:04 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][0/5] cifs: cifsfs.c cleanup
Message-ID: <Pine.LNX.4.62.0503251816530.2498@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Steve,

Here are the cleanups for fs/cifs/cifsfs.c

More or less the same drill as with the previous round of patches. I'll 
submit the patches inline, but once again they are available for you 
online if needed (I've included the notes about the specific patch in 
those files this time) : 

http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_cifsfs-whitespace-function-defs.patch
http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_cifsfs-whitespace-spaces.patch
http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_cifsfs-whitespace-comments.patch
http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_cifsfs-nesting.patch
http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_cifsfs-casts.patch

(listed in the order they apply)


-- 
Jesper Juhl


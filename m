Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbVCVUEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVCVUEM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 15:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbVCVUEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 15:04:12 -0500
Received: from mail.dif.dk ([193.138.115.101]:19377 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261790AbVCVUDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 15:03:14 -0500
Date: Tue, 22 Mar 2005 21:04:59 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
Cc: Steven French <sfrench@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH][0/6] cifs: readdir.c cleanup 
Message-ID: <Pine.LNX.4.62.0503222055150.2683@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Steve,

Here's one more cleanup for a file in fs/cifs - readdir.c (i'm going to 
follow the order you told me you'd prefer first, then do the remaining 
files in arbitrary order).
I'm going to send the patches inline to make it easy for others to comment 
if they so choose, but since you had problems with inline patches from me 
last time I've also placed them online for you :

http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_readdir-whitespace-cleanup-1.patch
http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_readdir-whitespace-cleanup-2.patch
http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_readdir-whitespace-cleanup-3.patch
http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_readdir-kfree-cleanup.patch
http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_readdir-cast-cleanup.patch
http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_readdir-whitespace-cleanup-final-bits.patch

(listed in the order they apply)


Short description of each patch will be in the email with that patch 
inline that will follow shortly.


-- 
Jesper Juhl


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbVCZNys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbVCZNys (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 08:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVCZNys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 08:54:48 -0500
Received: from mail.dif.dk ([193.138.115.101]:34708 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262078AbVCZNyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 08:54:35 -0500
Date: Sat, 26 Mar 2005 14:56:33 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][0/6] cifs: inode.c cleanup 
Message-ID: <Pine.LNX.4.62.0503261452260.2488@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

	Here are the cleanup patches for fs/cifs/inode.c
	Same procedure as last time.

	Patches will be send inline, but are also here : 

	http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_inode-function-defs.patch
	http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_inode-spaces.patch
	http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_inode-comments.patch
	http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_inode-kfree.patch
	http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_inode-cast.patch
	http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_inode-nest.patch

	(listed in the order they apply)


-- 
Jesper Juhl


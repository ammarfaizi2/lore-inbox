Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVDDVCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVDDVCf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 17:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVDDU7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 16:59:18 -0400
Received: from host201.dif.dk ([193.138.115.201]:4356 "EHLO
	diftmgw2.backbone.dif.dk") by vger.kernel.org with ESMTP
	id S261413AbVDDU6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 16:58:20 -0400
Date: Mon, 4 Apr 2005 22:59:32 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
cc: Steven French <sfrench@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] cifs: cleanup asn1.c 
Message-ID: <Pine.LNX.4.62.0504042254540.2496@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Steve,

More fs/cifs/ cleanups for you. This time for asn1.c

Same stuff as all the previous ones; split into parts that do just one 
thing (or a few very closely related), follows the style(s) established in 
the previous patches.

Patches will be send inline in mails with descriptions shortly, but for 
your convenience they are also available here:
	http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_asn1-functions.patch
	http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_asn1-kfree.patch
	http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_asn1-spacing-and-long-lines.patch
	http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_asn1-comments.patch
		(listed in the order they apply)


-- 
Jesper Juhl



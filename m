Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269415AbUIIKcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269415AbUIIKcr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 06:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269414AbUIIKcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 06:32:47 -0400
Received: from mailbox.surfeu.se ([213.173.154.11]:424 "EHLO surfeu.fi")
	by vger.kernel.org with ESMTP id S269410AbUIIKco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 06:32:44 -0400
Message-ID: <414031A6.40A58D77@users.sourceforge.net>
Date: Thu, 09 Sep 2004 13:34:14 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-crypto@nl.linux.org
CC: linux-kernel@vger.kernel.org
Subject: Announce loop-AES-v2.2b file/swap crypto package
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

loop-AES changes since previous release:
- Fixed queue->issue_flush_fn() bug that slipped to loop-AES-v2.2a and only
  affected barrier mounts on 2.6.9-rc and later kernels.

bzip2 compressed tarball is here:

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v2.2b.tar.bz2
    md5sum a0fef265f8cc71dfc55856d59ce81ddf

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v2.2b.tar.bz2.sign

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbUJZRqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbUJZRqF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 13:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbUJZRqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 13:46:05 -0400
Received: from mailbox.surfeu.se ([213.173.154.11]:24528 "EHLO surfeu.fi")
	by vger.kernel.org with ESMTP id S261358AbUJZRof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 13:44:35 -0400
Message-ID: <417E8D6A.E187A858@users.sourceforge.net>
Date: Tue, 26 Oct 2004 20:46:18 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-crypto@nl.linux.org
CC: linux-kernel@vger.kernel.org
Subject: Announce loop-AES-v2.2d file/swap crypto package
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

loop-AES changes since previous release:
- Fixed mount so that it can set desired initial permissions for loop
  mounted encrypted file system root directory with random keys. This fix
  corrects README example 4 unwritable encrypted /tmp problem of
  loop-AES-v2.2c.

bzip2 compressed tarball is here:

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v2.2d.tar.bz2
    md5sum 1de89f3967b8fa74b5f98bc0fb099de2

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v2.2d.tar.bz2.sign

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD

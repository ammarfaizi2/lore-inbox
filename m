Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbVFROXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVFROXF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 10:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbVFROXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 10:23:04 -0400
Received: from mail.tnnet.fi ([217.112.240.26]:49079 "EHLO mail.tnnet.fi")
	by vger.kernel.org with ESMTP id S262123AbVFROXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 10:23:00 -0400
Message-ID: <42B42E3B.DDEFE309@users.sourceforge.net>
Date: Sat, 18 Jun 2005 17:22:51 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-crypto@nl.linux.org
Cc: linux-kernel@vger.kernel.org
Subject: Announce loop-AES-v3.0d file/swap crypto package
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

loop-AES changes since previous release:
- Added support for Red Hat installer specific LOOP_CHANGE_FD ioctl. Patch
  from David Eduardo Gomez Noguera. (2.6 kernels)
- Added support for compat_ioctl. (2.6 kernels)
- Changed build-initrd.sh script to accept both old and new style ldd
  program output.
- gcc4 cleanups.

bzip2 compressed tarball is here:

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.0d.tar.bz2
    md5sum 650186003f301362247a7d16f138eb43

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.0d.tar.bz2.sign

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD

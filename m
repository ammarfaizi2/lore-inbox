Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbVIXPPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbVIXPPX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 11:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVIXPPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 11:15:23 -0400
Received: from mail.tnnet.fi ([217.112.240.26]:5538 "EHLO mail.tnnet.fi")
	by vger.kernel.org with ESMTP id S932191AbVIXPPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 11:15:22 -0400
Message-ID: <43356D6F.95B04C3A@users.sourceforge.net>
Date: Sat, 24 Sep 2005 18:14:55 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
To: linux-crypto@nl.linux.org
Cc: linux-kernel@vger.kernel.org
Subject: Announce loop-AES-v3.1b file/swap crypto package
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

loop-AES changes since previous release:
- Added block I/O priority support. (2.6 kernels)
- Added VIA padlock hardware AES support. (2.4 and 2.6 kernels)
- Added losetup -R option which recomputes size of loop device. Useful with
  loop device on top of LVM volume. Patch from Jim MacBaine. (2.4 and 2.6
  kernels)

bzip2 compressed tarball is here:

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.1b.tar.bz2
    md5sum ab453b8d81bd36d5e56e391ee36ec5d6

    http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.1b.tar.bz2.sign

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD

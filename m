Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280343AbRKNIUL>; Wed, 14 Nov 2001 03:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280351AbRKNIUB>; Wed, 14 Nov 2001 03:20:01 -0500
Received: from mail.cb.monarch.net ([24.244.11.6]:23056 "EHLO
	baca.cb.monarch.net") by vger.kernel.org with ESMTP
	id <S280343AbRKNITy>; Wed, 14 Nov 2001 03:19:54 -0500
Date: Wed, 14 Nov 2001 01:17:32 -0700
From: "Peter J. Braam" <braam@clusterfilesystem.com>
To: linux-kernel@vger.kernel.org
Subject: Makefile for external modules
Message-ID: <20011114011732.D18465@lustre.dyn.ca.clusterfilesystem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Rumor has it that there is now a simple way to build modules outside
the kernel tree.  I'm told that you place a kernel style makefile in
your directory and do:

make -C /usr/src/linux MOD_SUB_DIRS=/my/module/dir modules

It almost works, but loops. What is wrong? 

Thanks!

- Peter -



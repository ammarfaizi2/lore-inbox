Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264920AbTBTKuP>; Thu, 20 Feb 2003 05:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265140AbTBTKuO>; Thu, 20 Feb 2003 05:50:14 -0500
Received: from penguin-ext.wise.edt.ericsson.se ([193.180.251.47]:47593 "EHLO
	penguin.wise.edt.ericsson.se") by vger.kernel.org with ESMTP
	id <S264920AbTBTKuM>; Thu, 20 Feb 2003 05:50:12 -0500
X-Sybari-Trust: da073815 9ffcebbb 7a95d2f4 00000138
From: Miklos.Szeredi@eth.ericsson.se (Miklos Szeredi)
Date: Thu, 20 Feb 2003 11:59:54 +0100 (MET)
Message-Id: <200302201059.h1KAxsg11519@duna48.eth.ericsson.se>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       avf-fuse-dev@lists.sourceforge.net
Subject: [ANNOUNCE] Filesystem in Userspace (FUSE) 1.0 stable release
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FUSE lets you write your very own filesystem, as an ordinary program.
It has a simple yet comprehensive interface, and provides an easy way
to create a virtual filesystem for just about any application.

Example applications include: automatic CD changer fs, remote
filesystems for handhelds, filesystem view for databases, etc...

FUSE currently works on all 2.4.x kernels (up to 2.4.20 and possibly
later).  Installation is simple, no kernel patching or recompilation
is needed.  Documentation for the interface and example programs are
provided in the package.

You can download the latest version from:

  http://sourceforge.net/projects/avf

Miklos

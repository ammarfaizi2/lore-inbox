Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbSI3SqR>; Mon, 30 Sep 2002 14:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261336AbSI3SqQ>; Mon, 30 Sep 2002 14:46:16 -0400
Received: from mnh-1-22.mv.com ([207.22.10.54]:33285 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S261290AbSI3SqQ>;
	Mon, 30 Sep 2002 14:46:16 -0400
Message-Id: <200209301955.OAA03608@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: uml-patch-2.5.39
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 30 Sep 2002 14:55:04 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UML has been updated to 2.5.39.

The build works again.

There were some block driver updates so UML will boot on an unpartitioned
disk.  I'll be merging changes which fix partitions.

This patch contains UML highmem support.

The patch is available at
	http://uml-pub.ists.dartmouth.edu/uml/uml-patch-2.5.39.bz2

For the other UML mirrors and other downloads, see 
	http://user-mode-linux.sourceforge.net/dl-sf.html

Other links of interest:

	The UML project home page : http://user-mode-linux.sourceforge.net
	The UML Community site : http://usermodelinux.org

				Jeff


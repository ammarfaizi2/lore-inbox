Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263181AbSJOQHS>; Tue, 15 Oct 2002 12:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263249AbSJOQHR>; Tue, 15 Oct 2002 12:07:17 -0400
Received: from mnh-1-28.mv.com ([207.22.10.60]:10757 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S263181AbSJOQHR>;
	Tue, 15 Oct 2002 12:07:17 -0400
Message-Id: <200210151717.MAA02888@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
cc: Oleg Drokin <green@namesys.com>, Mike Anderson <andmike@us.ibm.com>
Subject: uml-patch-2.5.42-2
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 15 Oct 2002 12:17:04 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.5.42 patch I released last night was broken.  This fixes those problems.

The build works again, and I merged the locking fixes that Oleg Drokin and 
Nikita Danilov pointed out.

The patch is available at
	http://uml-pub.ists.dartmouth.edu/uml/uml-patch-2.5.42-2.bz2

For the other UML mirrors and other downloads, see 
	http://user-mode-linux.sourceforge.net/dl-sf.html

Other links of interest:

	The UML project home page : http://user-mode-linux.sourceforge.net
	The UML Community site : http://usermodelinux.org

				Jeff


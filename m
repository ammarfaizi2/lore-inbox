Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266774AbUG1DX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266774AbUG1DX5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 23:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266775AbUG1DX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 23:23:57 -0400
Received: from [12.177.129.25] ([12.177.129.25]:196 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S266774AbUG1DXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 23:23:55 -0400
Message-Id: <200407280422.i6S4M7fL008720@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: uml-patch-2.6.7-1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 28 Jul 2004 00:22:07 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a belated patch that updates UML to 2.6.7.  The update was the only 
change from the 2.6.6 UML.

The next step will be the mm tree.  I'll get that UML fixed up, and start
splitting it into reasonable patches that Andrew is happy to feed to Linus.

The 2.6.7-1 UML patch is available at
	http://www.user-mode-linux.org/mirror/uml-patch-2.6.7-1.bz2

My BK tree is temporarily out of commission until I get my process feeding
patches from quilt into it.

For the other UML mirrors and other downloads, see 
        http://user-mode-linux.sourceforge.net/dl-sf.html
 
Other links of interest:
 
        The UML project home page : http://user-mode-linux.sourceforge.net
        The UML Community site : http://usermodelinux.org

				Jeff


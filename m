Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266569AbUBMRv2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 12:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267004AbUBMRv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 12:51:28 -0500
Received: from [12.177.129.25] ([12.177.129.25]:52163 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S266569AbUBMRv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 12:51:27 -0500
Message-Id: <200402131818.i1DIIRsq002831@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: uml-patch-2.6.3-rc2-1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 13 Feb 2004 13:18:27 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates UML to 2.6.3-rc2.  This breaks with my usual practice of
ignoring test patches.  However, when I updated my UML tree, I had forgotten
that my stock Linus tree was up to 2.6.3-rc2.  I took this as a sign from a
higher power that this was Meant To Be.

As well as catching up, there are some bug fixes and cleanups -
	modules should now work
	worked around a process start time bug
	fixed a bug which caused ps to divide by zero

The 2.6.3-rc2-1 UML patch is available at
	http://www.user-mode-linux.org/mirror/uml-patch-2.6.3-rc2-1.bz2

BK users can pull my 2.5 repository from
	http://www.user-mode-linux.org:5000/uml-2.5

For the other UML mirrors and other downloads, see 
        http://user-mode-linux.sourceforge.net/dl-sf.html
 
Other links of interest:
 
        The UML project home page : http://user-mode-linux.sourceforge.net
        The UML Community site : http://usermodelinux.org

				Jeff


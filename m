Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVDOMyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVDOMyW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 08:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVDOMyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 08:54:22 -0400
Received: from smartmx-03.inode.at ([213.229.60.35]:4029 "EHLO
	smartmx-03.inode.at") by vger.kernel.org with ESMTP id S261707AbVDOMyS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 08:54:18 -0400
Subject: Re: Sv: Re: Booting from USB with initrd
From: Bernhard Schauer <linux-kernel-list@acousta.at>
To: gabriel <gabriel.j@telia.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <22151575.1113557151100.JavaMail.tomcat@pne-ps1-sn2>
References: <22151575.1113557151100.JavaMail.tomcat@pne-ps1-sn2>
Content-Type: text/plain
Date: Fri, 15 Apr 2005 14:54:36 +0200
Message-Id: <1113569677.5347.27.camel@FC3-bernhard-1.acousta.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you edit the build-initrd.sh script to fit your needs? 

Does 
  http://featherlinux.berlios.de/usb-instructions.htm or
  http://www.ussg.iu.edu/hypermail/linux/kernel/0211.1/0551.html help?)

Totally different Q's: 

Have you called syslinux with the correct parameter to find your
initrd.gz? 

Do you have access to DOS bootable drive (To try to boot the kernel
using loadlin from DOS command prompt. If that works you know that the
issues are regarded to syslinux, if not - initrd/kernel) (?) 

Have you tried to boot kernel + initrd from your local linux
installation?

regards





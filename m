Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265337AbTLSEcI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 23:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265339AbTLSEcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 23:32:08 -0500
Received: from outbound02.telus.net ([199.185.220.221]:23996 "EHLO
	priv-edtnes04.telusplanet.net") by vger.kernel.org with ESMTP
	id S265337AbTLSEcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 23:32:06 -0500
Subject: samba problems
From: Lee Robbins <aridhol@telus.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1071808425.14475.8.camel@gentoo.leetnix.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 18 Dec 2003 20:33:46 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 I'm having a weird problem since upgrading to kernel 2.6, I have 2
drives mounted through samba but if the samba machine goes down for a
reboot and then comes back I can no longer ls the dir that has the dir's
i am using for the mount points. I have to manually unmount and remount
to be able to ls or do anything in that directory. I can't browse for
files with xine either. It's like the machine going down freezes that
directory. 

With 2.4.21 the machine with the samba shares would go down for reboot
(windows gaming machine) and I could ls in the directory (home/username/
which would contain /home/username/share1 etc..) and browse with xine
etc.. 


I'm running gentoo linux 1.4 with 2.6test11



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932498AbVKLUWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbVKLUWw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 15:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbVKLUWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 15:22:52 -0500
Received: from serena.fsr.ku.dk ([130.225.215.194]:55517 "EHLO
	serena.fsr.ku.dk") by vger.kernel.org with ESMTP id S932498AbVKLUWv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 15:22:51 -0500
To: linux-kernel@vger.kernel.org
Subject: gen_initramfs_list.sh: Cannot open 'y'
From: Henrik Christian Grove <grove@fsr.ku.dk>
Organization: Forenede =?iso-8859-1?q?Studenterr=E5d_ved_K=F8benhavns?= Universitet
Date: Sat, 12 Nov 2005 21:22:42 +0100
Message-ID: <7gk6fdy5t9.fsf@serena.fsr.ku.dk>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When I try to compile a 2.6.14 kernel on my new laptop, I get the
following error:
x40:~/kerne/linux-2.6.14# make
  CHK     include/linux/version.h
  CHK     include/linux/compile.h
dnsdomainname: Host name lookup failure
  CHK     usr/initramfs_list
  /root/kerne/linux-2.6.14/scripts/gen_initramfs_list.sh: Cannot open 'y'
make[1]: *** [usr/initramfs_list] Error 1
make: *** [usr] Error 2

I simply don't understand what it's trying to do, and google doesn't
seem to know that error. Can anyone here help?

.Henrik

-- 
"Det er fundamentalt noget humanistisk vås, at der er noget, 
 der hedder blød matematik."
   --- citat Henrik Jeppesen, dekan for det naturvidenskabelige fakultet

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266527AbUBRW4m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 17:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267068AbUBRW4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 17:56:42 -0500
Received: from vsmtp14.tin.it ([212.216.176.118]:15009 "EHLO vsmtp14.tin.it")
	by vger.kernel.org with ESMTP id S266527AbUBRWx4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 17:53:56 -0500
From: Marco Gulino <rockman81@tin.it>
To: linux-kernel@vger.kernel.org
Subject: 2.6.3: lilo warnings
Date: Wed, 18 Feb 2004 23:53:41 +0100
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402182353.41899.rockman81@tin.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! When i upgraded from linux kernel 2.6.2 to 2.6.3 i get these warnings when 
i run lilo... my system is all ok, however, i'm only reporting these 
warnings.
My distro is GNU/Linux Slackware 9.1
Thanks :-)

bash-2.05b# lilo
Warning: '/proc/partitions' does not match '/dev' directory structure.
    Name change: '/dev/ram8' -> '/tmp/dev.0'
Warning: '/dev' directory structure is incomplete; device (1, 8) is missing.
Warning: '/dev' directory structure is incomplete; device (1, 9) is missing.
Warning: '/dev' directory structure is incomplete; device (1, 10) is missing.
Warning: '/dev' directory structure is incomplete; device (1, 11) is missing.
Warning: '/dev' directory structure is incomplete; device (1, 12) is missing.
Warning: '/dev' directory structure is incomplete; device (1, 13) is missing.
Warning: '/dev' directory structure is incomplete; device (1, 14) is missing.
Warning: '/dev' directory structure is incomplete; device (1, 15) is missing.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266485AbUAVUYE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 15:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266486AbUAVUYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 15:24:04 -0500
Received: from turkey.mail.pas.earthlink.net ([207.217.120.126]:55764 "EHLO
	turkey.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S266485AbUAVUYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 15:24:02 -0500
Message-ID: <40103160.5070304@earthlink.net>
Date: Thu, 22 Jan 2004 15:24:00 -0500
From: Stephen Clark <stephen.clark@earthlink.net>
Reply-To: sclark46@earthlink.net
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.2-rc1
X-Enigmail-Version: 0.76.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello gentle people,

I searched for other problems like this but to no avail.
Any ideas why my swapon from rh9 won't work?


[root@joker root]# mkswap /dev/hda2
Setting up swapspace version 1, size = 1077506 kB
[root@joker root]# mkswap /dev/hde2
Setting up swapspace version 1, size = 542863 kB
[root@joker root]# swapon -v -a
swapon on /dev/hda2
swapon: /dev/hda2: Function not implemented
swapon on /dev/hde2
swapon: /dev/hde2: Function not implemented

Thanks,
Steve



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293057AbSCEA3F>; Mon, 4 Mar 2002 19:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293065AbSCEA2z>; Mon, 4 Mar 2002 19:28:55 -0500
Received: from web21206.mail.yahoo.com ([216.136.175.8]:25642 "HELO
	web21206.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S293057AbSCEA2o>; Mon, 4 Mar 2002 19:28:44 -0500
Message-ID: <20020305002843.30834.qmail@web21206.mail.yahoo.com>
Date: Mon, 4 Mar 2002 16:28:43 -0800 (PST)
From: aryan aru <aryan222is@yahoo.com>
Subject: netlink vs ioctl
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

For the communication between user space and kernel
space, which one would give more performance - netlink
or ioctl.

When used ioremap_nocache to map from user space to
kernel space does it do cache flush ?

Any help is highly appreciated.

thanks in advance

regards
aryan


__________________________________________________
Do You Yahoo!?
Yahoo! Sports - sign up for Fantasy Baseball
http://sports.yahoo.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbTJNTfz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 15:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbTJNTfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 15:35:55 -0400
Received: from havoc.gtf.org ([63.247.75.124]:56545 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262407AbTJNTcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 15:32:18 -0400
Date: Tue, 14 Oct 2003 15:32:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [BK PATCHES] 2.4.x experimental net driver updates
Message-ID: <20031014193214.GA23154@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


BK users:

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.4-exp

GNU diff:
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.4/2.4.22-bk34-netdrvr-exp1.patch.bz2

This will update the following files:

 drivers/net/8139too.c    |   51 +++++++++++++++--------
 drivers/net/Makefile.lib |    1 
 drivers/net/natsemi.c    |  101 +++++++++++++++--------------------------------
 3 files changed, 68 insertions(+), 85 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/10/14 1.1191)
   [netdrvr natsemi] backport 2.6 fixes and cleanups

<krishnakumar@naturesoft.net> (03/10/14 1.1190)
   [netdrvr 8139too] support netif_msg_* interface


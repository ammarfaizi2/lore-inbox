Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264262AbUDSCv6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 22:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbUDSCv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 22:51:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:36781 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264251AbUDSCv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 22:51:57 -0400
Date: Sun, 18 Apr 2004 19:51:28 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, zwane@linuxpower.ca
Subject: [PATCH] run floppy98.c thru Lindent
Message-Id: <20040418195128.3a5d6fd1.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Large patch (over 100 KB), so please get it from:
  http://developer.osdl.org/rddunlap/patches/floppy98_lindent.patch

Verified:  same code before and after except for __LINE__ numbers.

diffstat:=
 drivers/block/floppy98.c | 1535 +++++++++++++++++++++++------------------------
 1 files changed, 773 insertions(+), 762 deletions(-)


--
~Randy

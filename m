Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbTI3NYv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 09:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbTI3NYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 09:24:51 -0400
Received: from peabody.ximian.com ([141.154.95.10]:38279 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261589AbTI3NQZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 09:16:25 -0400
Subject: make install problems
From: Kevin Breit <mrproper@ximian.com>
Reply-To: mrproper@ximian.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Ximian, Inc.
Message-Id: <1064927778.1575.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 30 Sep 2003 09:16:19 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,
	I setup a test6 kernel without module support.  I did a make install
and got:

Kernel: arch/i386/boot/bzImage is ready
sh /usr/src/linux-2.6.0-test6/arch/i386/boot/install.sh 2.6.0-test6
arch/i386/boot/bzImage System.map ""
/lib/modules/2.6.0-test6 is not a directory.
mkinitrd failed

How can I fix this?

Thanks

Kevin Breit


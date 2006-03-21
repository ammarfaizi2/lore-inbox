Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751690AbWCUNhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbWCUNhS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 08:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbWCUNhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 08:37:18 -0500
Received: from smtp-14.masterhost.ru ([83.222.24.114]:42306 "HELO
	smtp-14.masterhost.ru") by vger.kernel.org with SMTP
	id S1751690AbWCUNhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 08:37:16 -0500
Date: Tue, 21 Mar 2006 16:36:50 +0300
From: Evgeny Stepanischev <bolk@hitv.ru>
X-Priority: 3 (Normal)
Message-ID: <506113975.20060321163650@hitv.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16/piix
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can't run 2.6.16 kernel.


# make install

sh /usr/src/linux-2.6.16/arch/i386/boot/install.sh 2.6.16 arch/i386/boot/bzImage System.map "/boot"
WARNING: No module ata_piix found for kernel 2.6.16, continuing anyway

Than I reboot I see "can't find superblock: kernel panic"


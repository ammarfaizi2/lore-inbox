Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264924AbTGGXjv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 19:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264939AbTGGXjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 19:39:51 -0400
Received: from L1028P03.dipool.highway.telekom.at ([62.46.192.99]:64150 "EHLO
	bld.ods.org") by vger.kernel.org with ESMTP id S264924AbTGGXju
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 19:39:50 -0400
Date: Tue, 8 Jul 2003 01:54:23 +0200
From: Hans-Peter Schadler <blade.runner@gmx.at>
To: linux-kernel@vger.kernel.org
Subject: 2.4.22-pre3-ac1: bcm4400 transfer problems
Message-Id: <20030708015423.35f59b47.blade.runner@gmx.at>
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have some strange problems with the bcm4400 driver
Bigger transfers from any other PC to my PC doesnt work (so receiving seams to be the problem)

Very easy to reproduce this problem is, to ping a other pc with packages greater then  approximatly 3000byte (ping -s 3000)

The Other thing is nfs. This also shows this problem very fast. I couldnt copy a file bigger then some bytes from server to my PC. From my PC to the server works without any problems.

I don't know what infos i should give you, and what infos could be usefull. There are no errors or messages in /var/log/messages or /var/log/syslog.

I have activated acpi, but i also have the problem, without it.

Best regards
Hans-Peter Schadler

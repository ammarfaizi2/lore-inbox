Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbVHYAVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbVHYAVG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 20:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbVHYAVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 20:21:06 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:22924 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932412AbVHYAVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 20:21:05 -0400
Date: Thu, 25 Aug 2005 02:20:54 +0200
From: Voluspa <lista1@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.13-rc7
Message-Id: <20050825022054.352f6ebb.lista1@telia.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


root:sleipner:~# modprobe hotkey
FATAL: Error inserting hotkey
(/lib/modules/2.6.13-rc7/kernel/drivers/acpi/hotkey.ko): No such device

Not that I care, but it at least loaded in -rc6 and created the
/proc/acpi/hotkey directory with its content.

When the revolution comes, the author of acpi-hotkey.txt will face the
wall first.

Mvh
Mats Johannesson
--

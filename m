Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbUJWQlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbUJWQlH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 12:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbUJWQlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 12:41:06 -0400
Received: from pooh.lsc.hu ([195.56.172.131]:19336 "EHLO pooh.lsc.hu")
	by vger.kernel.org with ESMTP id S261237AbUJWQk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 12:40:27 -0400
Date: Sat, 23 Oct 2004 18:33:03 +0200
From: "Laszlo 'GCS' Boszormenyi" <gcs@lsc.hu>
To: linux-kernel@vger.kernel.org
Subject: poweroff does reboot on Gericom laptop
Message-ID: <20041023163303.GA24519@pooh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Whitelist: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 I got my laptop back when 2.4.14 was released, and since then poweroff
always worked; until 2.6.8.1, but with recent kernels the system reboots
instead. I have tried: 2.6.9, -final, -rc4, -rc3, -rc2, 2.6.10-rc1 but
the problem persists. Before I get asked, I have all APIC turned off,
and I must use ACPI otherwise I have bad irq problems. The laptop itself
is a PIII 1.2 Ghz one, running Debian GNU/Linux (Sarge).
I have tried searching around, but couldn't dig up anything. Anyone
experiencing this as well? What can I try to locate and hopefully fix
this problem?

Thanks in advance,
Laszlo/GCS


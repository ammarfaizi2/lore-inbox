Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266022AbUF2UeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266022AbUF2UeF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 16:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266025AbUF2UeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 16:34:05 -0400
Received: from mail.mysnip.de ([194.25.82.167]:43951 "EHLO mail.mysnip.de")
	by vger.kernel.org with ESMTP id S266022AbUF2Udd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 16:33:33 -0400
Date: Tue, 29 Jun 2004 22:33:28 +0200
From: Thomas Seifert <thomas-lists@mysnip.de>
To: linux-kernel@vger.kernel.org
Subject: a couple of powernow-k8 questions
Message-Id: <20040629223328.68eff5e9.thomas-lists@mysnip.de>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I'm running an athlon64 3000+ on an epox-mainboard.

after some bios-upgrades through their support I'm getting at least a bit
of powernow-support ;)

Through startup I'm getting these messages now:

powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.00.09b)
powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x2 (1500 mV)
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
powernow-k8:    2 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
powernow-k8: cpu_init done, current fid 0xc, vid 0x2
ACPI: (supports S0 S1 S4 S5)


Just to confirm: does that mean only these modes are supported? 
Wasn't there something down to 800 MHz for the athlon64-processors?
Is this a problem of the mainbord (aka still their bios ;)) or of
the driver?
Any way to workaround this?




Thanks in advance,

Thomas

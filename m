Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVBPUVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVBPUVR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 15:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbVBPUVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 15:21:13 -0500
Received: from giesskaennchen.de ([83.151.18.118]:53694 "EHLO
	mail.uni-matrix.com") by vger.kernel.org with ESMTP id S261862AbVBPUUw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 15:20:52 -0500
Message-ID: <4213AB2B.2050604@giesskaennchen.de>
Date: Wed, 16 Feb 2005 21:20:59 +0100
From: Oliver Antwerpen <olli@giesskaennchen.de>
User-Agent: Mozilla Thunderbird 1.0RC1 (Windows/20041201)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug in SLES8 kernel 2.4.x freezing HP DL740/760
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-giesskaennchen.de-MailScanner-Information: Die Giesskaennchen verschicken keine Viren!
X-giesskaennchen.de-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi out there,

If there is anybody out there using SLES8 on HP ProLiant DL740/760:
BEWARE!

SuSE has patched UNICON into the kernel which will cause these servers 
to hang when booted with vga=normal. The system will run fine in 
fb-mode, but not in plain text.

I cannot see, where this UNICON-patch comes from, it seems that is has 
been developed by some turbolinux-coders.

HP and SuSE have not been able to either fix this problem or at least 
warn someone about this bug, so I will do it now.
The bug is known since Nov 13th 2004.

If there should be anybody who can help, please contact me.

I hope this information will help someone to not run into deep trouble.

Oliver Antwerpen



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbVBOLPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVBOLPR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 06:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbVBOLPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 06:15:17 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:39044 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S261685AbVBOLPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 06:15:08 -0500
To: mike <mikelee@avantwave.com>
Cc: Linux kernel mailing <linux-kernel@vger.kernel.org>
Subject: Re: About kernel startup
References: <4211D9BE.9000703@avantwave.com>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Tue, 15 Feb 2005 11:15:24 +0000
In-Reply-To: <4211D9BE.9000703@avantwave.com> (mikelee@avantwave.com's
 message of "Tue, 15 Feb 2005 19:15:10 +0800")
Message-ID: <tnxd5v2axbn.fsf@arm.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mike <mikelee@avantwave.com> wrote:
>    When i start the non- compressed kernel, it can print out "Linux
> version 2.4.18-rmk4", and when i bootup the compressed kernel ,
> "uncompressed linux ......" is displayed. Both situation will reboot
> the machine and come back to the bootloader. Do anybody know what is
> the problem? Do i set anything wrong? Where should i start to debug in
> kernel?

Too little information. Since you are using an -rmk patch, is this on
an ARM CPU? You should try the ARM Linux mailing list
(http://www.arm.linux.org.uk/armlinux/mailinglists.php).

Catalin


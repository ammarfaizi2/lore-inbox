Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUE3PWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUE3PWm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 11:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263942AbUE3PWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 11:22:42 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:16133 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263664AbUE3PWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 11:22:41 -0400
Subject: Re: PROBLEM: kernel-2.6.7-rc1 ACPI and USB failures
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Roland Lewis <roland_wap@yahoo.co.uk>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20040529190631.78891.qmail@web86402.mail.ukl.yahoo.com>
References: <20040529190631.78891.qmail@web86402.mail.ukl.yahoo.com>
Content-Type: text/plain
Message-Id: <1085930551.1981.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Sun, 30 May 2004 17:22:31 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-05-29 at 21:06, Roland Lewis wrote:
> [1.] ACPI and USB failures in 2.6.7-rc1 
> [2.] CPU frequency table is not provided by DMESG at all.
> Soft-rebooting results in failure to reinitialise USB peripherals.
> Soft-rebooting causes Windows XP to hang during startup.
> [3.] kernel, ACPI, CPUFREQ, USB
> [4.] kernel-2.6.7-rc1

Please, try again with 2.6.7-rc2. Todd fixed the problems with USB
devices not resuming from suspend between rc1 and rc2.


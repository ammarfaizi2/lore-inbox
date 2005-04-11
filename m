Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbVDKUD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbVDKUD4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 16:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVDKUD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 16:03:56 -0400
Received: from web88008.mail.re2.yahoo.com ([206.190.37.195]:29624 "HELO
	web88008.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261909AbVDKUDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 16:03:53 -0400
Message-ID: <20050411200341.39635.qmail@web88008.mail.re2.yahoo.com>
Date: Mon, 11 Apr 2005 16:03:41 -0400 (EDT)
From: Shawn Starr <shawn.starr@rogers.com>
Subject: [2.6.12-rc2][suspend] Suspending Thinkpad: drive bay light in S3 mode stays on
To: Pavel Machek <pavel@ucw.cz>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I notice in Linux and in XP the drive bay light
remains on while the laptop is in suspend-to-RAM. I
know the ACPI  thinkpad extras added to the kernel
recently can turn this off. I wonder if we can/or need
to write hooks to turn the light off so to conserve
power when we're in S3

Thoughts?

Shawn.

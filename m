Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274973AbTHADMw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 23:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274975AbTHADMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 23:12:52 -0400
Received: from mail.msi.umn.edu ([128.101.190.10]:20173 "EHLO mail.msi.umn.edu")
	by vger.kernel.org with ESMTP id S274973AbTHADMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 23:12:50 -0400
Date: Thu, 31 Jul 2003 22:12:50 -0500
From: Michael Bakos <bakhos@msi.umn.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: compile error for Opteron CPU with kernel 2.6.0-test2
In-Reply-To: <20030731182705.5b4f2b33.akpm@osdl.org>
Message-ID: <Pine.SGI.4.33.0307312211191.23643-100000@ir12.msi.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I just tried ther kerne with my fix for arch/x86_64/kernel/mpparse.c
and it doesn't seem to work, when grub boot the kernel it reboots the
computer.


Michael Bakhos


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbTLPRv1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 12:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbTLPRv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 12:51:26 -0500
Received: from CPE-24-163-213-80.mn.rr.com ([24.163.213.80]:18908 "EHLO
	www.enodev.com") by vger.kernel.org with ESMTP id S261936AbTLPRue
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 12:50:34 -0500
Subject: Mainboard on which X86_UP_IOAPIC works? (mine crashes hard)
From: Shawn <core@enodev.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1071597008.2115.23.camel@www.enodev.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 16 Dec 2003 11:50:08 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking to replace my mainboard, and need some help.

I've got a Biostar M7VIB KT266 MB (w/ up-to-date BIOS), and my system
crashes reliably when UP-IO-APIC is enabled. In order to run linux at
all I have to disable it in the BIOS settings.

So... I'd like to find a board where people are currently running
UP-IOAPIC and don't get "APIC error on CPU[0]..." yadda errors preceding
a nice solid crash.

Anyone?

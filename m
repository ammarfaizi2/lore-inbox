Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbTKNKMm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 05:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbTKNKMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 05:12:42 -0500
Received: from gaia.cela.pl ([213.134.162.11]:5128 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S262251AbTKNKMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 05:12:42 -0500
Date: Fri, 14 Nov 2003 11:12:38 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: NMI Watchdog
Message-ID: <Pine.LNX.4.44.0311141110420.22146-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

How do I go about getting the NMI Watchdog to work on a Celeron Mendocino
400 MHz with no local APIC (nmi_watchdog=1/2 doesn't work, same kernel
works [/proc/interrupts show NMI's occuring 1/sec] on a 1GHz P3 with local
APIC)

Thanks,
MaZe.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263650AbUCUNQT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 08:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263652AbUCUNQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 08:16:19 -0500
Received: from host207-193-149-62.serverdedicati.aruba.it ([62.149.193.207]:15542
	"EHLO chernobyl.investici.org") by vger.kernel.org with ESMTP
	id S263650AbUCUNQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 08:16:10 -0500
Subject: new char device driver
From: Filippo Carone <f.carone@fastwebnet.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1079875079.13384.14.camel@marion>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 21 Mar 2004 14:17:59 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I wrote a GPL device driver for a PCI board, by Bihl-Wiedemann. The
device is this one:

http://www.bihl-wiedemann.de/englisch/catalog/1195.html

The code is based on an old device driver, by Ludolf Holzheild of
Bihl-Wiedemann, written for kernel 2.0 and early versions of 2.2. I
added some functions and ported it to 2.4 and 2.6.
The driver works fine, at least for the testing I did. Anyway since it's
my first attempt to a device driver, it may need some lifting.
Furthermore I used major number 60, since this driver doesn't have a
proper one.

Who should I send the driver to? Andrew Morton?

Cheers,
Filippo Carone


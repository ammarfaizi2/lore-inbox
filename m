Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbTFOTFo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 15:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbTFOTFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 15:05:11 -0400
Received: from beta.galatali.com ([216.40.241.205]:38294 "EHLO
	beta.galatali.com") by vger.kernel.org with ESMTP id S262720AbTFOTDb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 15:03:31 -0400
Subject: 2.5.71 won't boot, ACPI related
From: Tugrul Galatali <tugrul@galatali.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1055704641.564.8.camel@duality.galatali.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 15 Jun 2003 15:17:21 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Both .70 and .71, with the new ACPI rev, stop booting after spitting
out the following lines (transcribed by hand):

ACPI: Subsystem revision 20030522
    ACPI-0183: *** Error: Looking up [\_SB_.PCI0.LPC_.ECP0] in namespace, AE_NOT_FOUND
    ACPI-1121: *** Error: , AE_NOT_FOUND

	dmesg from 2.5.69, lspci and .config available at:

	http://acm.cs.nyu.edu/~tugrul/acpi/

	Otherwise, 2.5.69 is a fine release on my Compaq W8000.

	Tugrul Galatali



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264336AbTFKKhG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 06:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264340AbTFKKhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 06:37:06 -0400
Received: from magic-mail.adaptec.com ([208.236.45.100]:28820 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S264336AbTFKKhE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 06:37:04 -0400
From: "Mathur, Shobhit" <Shobhit_mathur@adaptec.com>
To: linux-kernel@vger.kernel.org
Message-ID: <3EE7B34C.B803F915@adaptec.com>
Date: Thu, 12 Jun 2003 04:25:08 +0530
Organization: Adaptec
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
Subject: Device-driver debugger on Linux ?
X-Priority: 1 (Highest)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I would like to know whether there exists a device-driver debugger on
Linux like SoftIce on Windows. From the working of kgdb, I understand
that the debugging on the Target machine can happen once the code
reaches the gdbstub, which is well past the driver-initialisations.

Can some light be shed on the possiblity of such source-level debugging
?

- Would be glad to receive help

- TIA

- Shobhit Mathur

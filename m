Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUCKQV6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 11:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbUCKQV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 11:21:58 -0500
Received: from math.ut.ee ([193.40.5.125]:16840 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261533AbUCKQVv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 11:21:51 -0500
Date: Thu, 11 Mar 2004 18:21:49 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: serial8250: too much work for irq4
Message-ID: <Pine.GSO.4.44.0403111820130.21805-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.3 worked OK, 2.6.4 gives me tons of these:
serial8250: too much work for irq4

These came while I was using minicom on serial port at 9600 bps to work
at the serial console of another host. The serial console worked fine.

Celeron 900, Intel 815 chipset onboard serial.

-- 
Meelis Roos (mroos@linux.ee)


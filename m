Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264990AbTGSJMO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 05:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265652AbTGSJMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 05:12:14 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:11420 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264990AbTGSJMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 05:12:14 -0400
Date: Sat, 19 Jul 2003 11:27:10 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test1: Promise 20265(R) driver appears to crash on boot
Message-ID: <20030719092709.GD10252@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I used 2.6.0-test1, without Promise driver, and got into init.

I then figured I'd forgotten the Promise driver, so I enabled it (linked
in) and the kernel crashes on boot since (tries to kill init).

Is this a know bug or should I post detailed crash dump information
(serial console is available -- does anyone have links to 3Com-based
ethernet kernel crash dumps with Linux 2.6?).

-- 
Matthias Andree

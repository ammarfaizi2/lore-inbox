Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266006AbTGAGLX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 02:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265999AbTGAGJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 02:09:58 -0400
Received: from otello.alma.unibo.it ([137.204.24.163]:65411 "EHLO
	otello.alma.unibo.it") by vger.kernel.org with ESMTP
	id S266005AbTGAGJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 02:09:34 -0400
Message-ID: <3F014378.6D3F598C@otello.alma.unibo.it>
Date: Tue, 01 Jul 2003 08:16:56 +0000
From: Diego Zuccato <diego@otello.alma.unibo.it>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.21-rc6-ac2 i686)
X-Accept-Language: it, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SIS IO-APIC troubles
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I'm trying to install Linux on an Acer Aspire 1700. To be able to boot,
I've had to use "noapic" parameter. But, then, many peripherals won't
work (like USB2) or they'll be sluggish (like nic that reaches about
80KB/s in a direct 100Mbps link).
I've put all the info I could gather at
http://otello.alma.unibo.it/~diego/Aspire1700/ .
Since it's not my machine, but a friend lets me experiment with it, it's
better if I have a list of tests to try.

Please CC: me as I'm not subscribed.

Tks,
 Diego.

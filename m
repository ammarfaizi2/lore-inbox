Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbULFR6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbULFR6a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 12:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbULFR6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 12:58:30 -0500
Received: from pop.gmx.net ([213.165.64.20]:16091 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261589AbULFR61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 12:58:27 -0500
X-Authenticated: #1425685
Date: Mon, 6 Dec 2004 18:56:55 +0100
From: Ostdeutschland <Ostdeutschland@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-rc3 vesafb does not like vga=316
Message-Id: <20041206185655.3a6d7ca1.Ostdeutschland@gmx.de>
X-Mailer: Sylpheed version 1.0.0beta2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

with updating to 2.6.10-rc3 i decided to test vesafb.
I added vga=0x318 to lilo.conf. (lilo version 22.6)
On reboot I see a message "..undefined mode number..."

The kernel asks me, to type the mode id, i would like to use.

mode id 315 is working, but 316, 317, 318, ... are not working.

I'm using a nvidia geforce 440mx card.

any ideas?

btw, rivafb does not work for me, too. it just gives me a black screen.

thanks, sebastian

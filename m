Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263063AbUCXTM1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 14:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263803AbUCXTM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 14:12:27 -0500
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:8789 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263063AbUCXTMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 14:12:24 -0500
Subject: 2.6.5-rc2: USB and events/0
From: "Raf D'Halleweyn" <list@noduck.net>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1080155541.10146.3.camel@base>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 24 Mar 2004 14:12:21 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I am running 2.6.5-rc2 on a Dell Latitude D600. If I boot with the USB
keyboard and mouse attached, those devices will not be found and they
will not function. If I plug them in after booting, they are found okay.

After unplugging and plugging back USB devices several times, now the
events/0 process is using more CPU than normal (~7%) and keyboard/mouse
use is sluggish.

Raf.

-- 
Raf D'Halleweyn <list@noduck.net>


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbTFZNXY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 09:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbTFZNXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 09:23:24 -0400
Received: from [62.12.131.37] ([62.12.131.37]:41631 "HELO debian")
	by vger.kernel.org with SMTP id S261365AbTFZNXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 09:23:23 -0400
Date: Thu, 26 Jun 2003 15:37:11 +0200
From: "Zeno R.R. Davatz" <zdavatz@ywesee.com>
To: linux-kernel@vger.kernel.org
Subject: eepro100 - solved.
Message-Id: <20030626153711.7cee5401.zdavatz@ywesee.com>
Organization: ywesee - intellectual capital connected
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got this one by myself. Sorry for the traffic.

Zeno

Hi List

I am doing a kernel with make-kpkg -rev ywesee.1 kernel_image

And then install it with dpkg -i kernel-image.... .deb

My maschine now boots great on the new 2.4.21 execpt that I do not have any network connection anymore.

I loaded the drivers for my onboard Intel Network eepro100 (plus the other two options below).

With the Debian Kernel bf24-2.4.20 my network connection is great...

Any hints anyone?

Thanks in advance.

Zeno

PS: Linux is great!

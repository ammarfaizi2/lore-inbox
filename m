Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266453AbUA2V2f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 16:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266452AbUA2V2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 16:28:34 -0500
Received: from mail.gmx.de ([213.165.64.20]:32212 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266451AbUA2V1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 16:27:46 -0500
X-Authenticated: #222435
Date: Thu, 29 Jan 2004 22:28:13 +0100
From: Jonas Diemer <diemer@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Which interface: sysfs, proc, devfs?
Message-Id: <20040129222813.3b22b2c8.diemer@gmx.de>
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I am writing a driver for an usb microcontroller (ezusb), which will be
used for measuring and controlling. I am confused on which interface to
use though. The driver is for kernel 2.6.x. 
I want to send small (human readable) commends as well as data (e.g.
firmware) to the device. Which filesystem is appropriate?

regards

Jonas

PS: Please CC me in replies, I am not subscribed to the list.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263779AbUCXRK2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 12:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263781AbUCXRK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 12:10:28 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:59331 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263779AbUCXRKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 12:10:24 -0500
Date: Wed, 24 Mar 2004 18:10:21 +0100
From: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6 Hotplugging
Message-Id: <20040324181021.2d495742.Christoph.Pleger@uni-dortmund.de>
Organization: Universitaet Dortmund
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; sparc-sun-solaris2.6)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am using Kernel 2.6.4 and the newest hotplug software from
ftp.kernel.org. When I hotplug a usb mass storage device, I get a
message like "disk at
/devices/pci0000:00/0000:00:1d.0/usb1/1-2/1-2:1.0/host1/1:0:0:0" on
tty1.

Where does this message come from and how can I prevent it from
appearing? Of course I do not want such a message because it corrupts
the text for example in the vi editor.

Regards
  Christoph

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263627AbTDGUSU (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 16:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263630AbTDGUSU (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 16:18:20 -0400
Received: from smtp-2.concepts.nl ([213.197.30.52]:17676 "EHLO
	smtp-2.concepts.nl") by vger.kernel.org with ESMTP id S263627AbTDGUST (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 16:18:19 -0400
Subject: [2.5.67/patch] Unified Zoran Driver update (take#2)
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: Frank Davis <fdavis@si.rr.com>
Cc: Gerd Knorr <kraxel@bytesex.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1049747457.20974.23.camel@tux.bitfreak.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 07 Apr 2003 22:30:59 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Frank/Greg/Gerd,

on http://mjpeg.sourceforge.net/driver-zoran/linux-zoran-driver.patch.gz
you'll find a new patch which updates the kernel zoran driver to the
newest version in the repository. It's updated against the i2c changes
between 2.5.66 -> 2.5.67. Besides that, no changes since the last try.

[rbultje@tux linux]$ md5sum /tmp/linux-zoran-driver.patch.gz
d5111b3b3a417b92fd7f6da6fe77287b  /tmp/linux-zoran-driver.patch.gz
[rbultje@tux linux]$

If any more changes are needed, please let me know. Thanks,

Thanks,

Ronald

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>


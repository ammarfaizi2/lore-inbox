Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbUBYP0N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 10:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbUBYP0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 10:26:13 -0500
Received: from ns2.mountaincable.net ([24.215.0.12]:35053 "EHLO
	ns2.mountaincable.net") by vger.kernel.org with ESMTP
	id S261357AbUBYP0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 10:26:10 -0500
Subject: [cross-post from linux-hotplug] input device sysfs stuff
From: desrt <desrt@desrt.ca>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1077722721.9193.1.camel@peloton.desrt.ca>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 25 Feb 2004 10:25:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[sorry for the blatant crosspost]
In reference to:
http://www.spinics.net/lists/kernel/msg239561.html

I'm running linux 2.6.3-bk5 and in my /sys/class/input/mouse* and event*
directories i only have one file 'dev'.  There are no 'device' and
'driver' symlinks.

Most people I've asked about this only have 'dev'.  I've found one
person who has the other files in place but I can't determine what's
different about our setups.

Is there maybe a patch I'm missing.

I'm not on the list so please direct replies to me directly.

Thanks,
Ryan


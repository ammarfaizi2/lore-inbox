Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265336AbUAJTaw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 14:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265338AbUAJT3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 14:29:33 -0500
Received: from chello080110072018.504.15.vie.surfer.at ([80.110.72.18]:9101
	"EHLO home.dilger.at") by vger.kernel.org with ESMTP
	id S265336AbUAJT3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 14:29:14 -0500
Message-ID: <4000528B.6010402@dilger.at>
Date: Sat, 10 Jan 2004 20:29:15 +0100
From: Matthias Dilger <matthias@dilger.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040108 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: fix typo in help text (drivers/input/mouse/Kconfig) in 2.6.1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

typo is present in 2.6.1 and -mm2. Please apply.

Greetings from Vienna,
Matthias

--- drivers/input/mouse/Kconfig.orig    2004-01-10 19:57:36.000000000 +0100
+++ drivers/input/mouse/Kconfig 2004-01-10 19:58:04.000000000 +0100
@@ -26,7 +26,7 @@
           Synaptics TouchPad users might be interested in a specialized
           XFree86 driver at:
                 http://w1.894.telia.com/~u89404340/touchpad/index.html
-         and a new verion of GPM at:
+         and a new version of GPM at:
                 http://www.geocities.com/dt_or/gpm/gpm.html
           to take advantage of the advanced features of the touchpad.
           If you do not want install specialized drivers but want tapping


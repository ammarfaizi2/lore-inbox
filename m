Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbTJECNa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 22:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbTJECNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 22:13:30 -0400
Received: from bgp01360964bgs.sandia01.nm.comcast.net ([68.35.68.128]:21888
	"EHLO orion.dwf.com") by vger.kernel.org with ESMTP id S262941AbTJECN3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 22:13:29 -0400
Message-Id: <200310050213.h952DSrA002997@orion.dwf.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: 2.6.0 - hid-core.c: control queue full
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 04 Oct 2003 20:13:28 -0600
From: reg@dwf.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is this error?  Twice now I have made what seemed
(at the time) simple changes to my config file, and each time
I have ended up with a kernel that spewed the message:

    drivers/usb/input/hid-core.c: control queue full

up the screen, late in the boot.  The only way out is with
a <ctl><alt><del>, and of course I had NEVER saved my previous
config file, so it is never obvious what change I had made.

Each time has wasted a couple of hours of debug time...

Any suggestions (other than 'dont try to use the USB stuff'...)
will be appreciated.

- -- 
                                        Reg.Clemens



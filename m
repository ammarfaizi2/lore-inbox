Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267771AbUBTJwA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 04:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267774AbUBTJwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 04:52:00 -0500
Received: from outbound02.telus.net ([199.185.220.221]:47491 "EHLO
	priv-edtnes04.telusplanet.net") by vger.kernel.org with ESMTP
	id S267771AbUBTJvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 04:51:53 -0500
Subject: Re: Any update on IEEE1394 for 2.6.3?
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1077270835.6042.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 20 Feb 2004 02:53:55 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  IEEE1394 _is_ working for 2.6.3.  Recent changes made it more
stable than ever (hotplugging is working with the most recent changes)
--at least for the hardware that I have.  If it isn't working for you
confirm your setup by following the guide for 2.6 at
http://www.linux1394.org/ (as things have changed since 2.4.x).  Also
you can get the latest changes from there, and recompile your kernel. If
it still isn't working, send a bug report (be sure to list your
hardware/chips, the kernel modules you have loaded, error messages, the
kernel version, and any relevant debug information from dmesg or
/var/log/messages) to the 1394 maintainer.  

Cheers,

Bob


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262860AbTJ3WxS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 17:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262898AbTJ3WxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 17:53:18 -0500
Received: from [65.42.175.122] ([65.42.175.122]:3053 "HELO
	delorean.solidusdesign.com") by vger.kernel.org with SMTP
	id S262860AbTJ3WxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 17:53:17 -0500
Message-ID: <1067552357.3fa18e65d1fca@secure.solidusdesign.com>
Date: Thu, 30 Oct 2003 17:19:17 -0500
From: Dave Brondsema <dave@brondsema.net>
To: linux-kernel@vger.kernel.org
Subject: uptime reset after about 45 days
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 12.241.185.144
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After about 45 days or so, my uptime was reset. My idle time is correct.

$ cat /proc/uptime
94245.37 3686026.54

$ cat /proc/version
Linux version 2.4.20-gentoo-r1 (root@dpb2.resnet.calvin.edu) (gcc version 3.2.2)
#6 SMP Thu Apr 17 14:11:34 EDT 2003


-- 
Dave Brondsema 
dave@brondsema.net 
http://www.brondsema.net - personal 
http://www.splike.com - programming 
http://csx.calvin.edu - student org 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262379AbULOQ0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbULOQ0R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 11:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbULOQ0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 11:26:17 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:37313 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262379AbULOQ0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 11:26:14 -0500
Message-ID: <41C065A2.4040504@nortelnetworks.com>
Date: Wed, 15 Dec 2004 10:26:10 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: slow OOM killing with 2.6.9?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a ppc box with 2GB of ram, running 2.6.9.

If I run a few instances of memory chewing programs, eventually the OOM-killer 
kicks in.  At that point, the machine locks up for about 10 seconds while 
deciding what to kill.

Is this expected behaviour?  Is there any way to speed this up?

Thanks,

Chris

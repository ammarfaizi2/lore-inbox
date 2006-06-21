Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751568AbWFUNKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbWFUNKt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 09:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbWFUNKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 09:10:48 -0400
Received: from main.gmane.org ([80.91.229.2]:57304 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751566AbWFUNKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 09:10:48 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ilya Yanok <ilya.yanok@gmail.com>
Subject: [RFC] usb gadget connect/disconnect events
Date: Wed, 21 Jun 2006 13:07:34 +0000 (UTC)
Message-ID: <loom.20060621T150420-92@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 81.23.122.40 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050517 Firefox/1.0.4 (Debian package 1.0.4-2))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I need to get usb device connect/disconnect events in user space. What should I
use? hotplug? kobject/uevent? And there is the right place to add this stuff?

Thanks in advance,
                  Ilya.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266611AbUIJKGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266611AbUIJKGR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 06:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266808AbUIJKGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 06:06:16 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:24588 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S266611AbUIJKGO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 06:06:14 -0400
Date: Fri, 10 Sep 2004 11:11:57 +0100
To: linux-kernel@vger.kernel.org
Subject: How do I stop make building all modules after reboot?
From: "Bill Adair" <biotrace@nildram.co.uk>
Organization: Biotrace
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opsd3vx7i3u7wa79@smtp.nildram.co.uk>
User-Agent: Opera M2/7.54 (Linux, build 751)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quick question as above. I'm building an i2c module. If I don't reboot
the machine "make modules" works as expected and just recompiles my  
changes.
After a reboot I have to wait 1 hour + (two smp P3 866s) while all modules  
are built. I've had a look in the Makefile but can't spot the dependancy.
TIA
Bill

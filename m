Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267352AbUHEETp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267352AbUHEETp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 00:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267359AbUHEETo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 00:19:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:18348 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267352AbUHEETn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 00:19:43 -0400
Subject: Status with pmdisk/swsusp merge ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Mochel <mochel@digitalimplant.org>, Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1091679494.5225.186.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 05 Aug 2004 14:18:15 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

What is the status with those patches ?

I have some additional stuff to drop on top of it, including the basic
PPC support, some renumbering of the states as discussed earlier, some
driver fixes etc.... but at this point, I feel it would be more handy
to get those in only after Patrick core changes have been merged with
Linus. Do we wait for 2.6.9 to open ?

Ben.
  


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267667AbVBEUyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267667AbVBEUyD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 15:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267621AbVBEUyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 15:54:02 -0500
Received: from smtp105.rog.mail.re2.yahoo.com ([206.190.36.83]:27267 "HELO
	smtp105.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S267667AbVBEUx7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 15:53:59 -0500
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: LKML <linux-kernel@vger.kernel.org>
Subject: [2.6.11-rc3] - Slow boot up
Date: Sat, 5 Feb 2005 15:54:01 -0500
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200502051554.01988.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From -rc2 to -rc3 I noticed a serious slowdown during initial bootup, it takes 
the system a lot longer to probe devices.

Anyone else noticed this? I have a T42 laptop, I will be testing this on 
another system to see if this is noticed as well.

Shawn.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVDMQhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVDMQhu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 12:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVDMQhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 12:37:50 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:47502 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261388AbVDMQhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 12:37:45 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.12-rc2*: CD recorder problem
Date: Wed, 13 Apr 2005 18:37:42 +0200
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504131837.42930.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On the kernels above and including 2.6.12-rc2 k3b is unable to operate my
IDE CD recorder.  First time (after a fresh reboot) I start it, it detects the
recorder properly, but then it refuses to work (it says the media is unknown).
After k3b is restarted, it can't even detect the drive.

The problem does not occur on 2.6.11.  I don't know whether it happens for the
kernels between 2.6.11 and 2.6.12-rc2, but I can check if that's necessary.

Please let me know if you need any more information.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

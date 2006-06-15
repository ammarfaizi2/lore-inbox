Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030331AbWFOMfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbWFOMfY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 08:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030339AbWFOMfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 08:35:24 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:11277 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S1030331AbWFOMfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 08:35:23 -0400
Message-ID: <4491540A.6050806@onelan.co.uk>
Date: Thu, 15 Jun 2006 13:35:22 +0100
From: Barry Scott <barry.scott@onelan.co.uk>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-rc6 No volume groups found
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my HP dc7600U having patch around the MCG problem
I now get a bit further. Previous working kernel was 2.6.16
from Fedora Code 4.

I see:

Uncompressing Linux... Ok, botinh the kernel.
Red Hat nash version 4.2.15 starting
  Reading all physical volumes.  This may take a while...
  No volume groups found
  Unable to find volume group "VolGroup00"
ERROR: /bin/lvm exited abnormally with value 5 ! (pid 351)

Then a few more errors and Kernel panic

Where would the problem be?

Barry


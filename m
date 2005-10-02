Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbVJBAbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbVJBAbA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 20:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbVJBAbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 20:31:00 -0400
Received: from hulk.vianw.pt ([195.22.31.43]:451 "EHLO hulk.vianw.pt")
	by vger.kernel.org with ESMTP id S1750922AbVJBAa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 20:30:59 -0400
Message-ID: <433F2A30.6080308@esoterica.pt>
Date: Sun, 02 Oct 2005 01:30:40 +0100
From: Paulo da Silva <psdasilva@esoterica.pt>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: LVM and lilo: a problem!
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using LVM for a couple of weeks.
No functional problems at all.

However, I needed to run lilo and got the
following message:

Warning: '/proc/partitions' does not match '/dev' directory structure.
    Name change: '/dev/dm-0' -> '/dev/VSDB/gtpalma'

'/dev/VSDB/gtpalma' is a logical volume I created and is
working fine anyway.

What does this mean?
Should I do anything to avoid the message?

Thanks.


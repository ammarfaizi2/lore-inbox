Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbULHWYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbULHWYY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 17:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbULHWYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 17:24:24 -0500
Received: from rav-az.mvista.com ([65.200.49.157]:5735 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S261377AbULHWWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 17:22:38 -0500
Message-ID: <41B7821B.7070001@mvista.com>
Date: Wed, 08 Dec 2004 15:37:15 -0700
From: Randy Vinson <rvinson@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
CC: akpm@osdl.org
Subject: [PATCH][PPC32] Add Support for IBM 750FX and 750GX Eval Boards
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,
   I've added support for the IBM 750FX and 750GX Eval Boards
(Chestnut/Buckeye). This patch is against 2.6.10-rc3. The patch relies
on the 2 MV64x60 patches and the EV64260 patch previously posted by M.
Greer. Please apply.

Signed-off-by: Randy Vinson <rvinson@mvista.com>

My patch is over the 40K limit, so it can be found at
ftp://source.mvista.com/pub/rvinson/chestnut.patch


	Thanks
	Randy Vinson












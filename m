Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286366AbRLTU0X>; Thu, 20 Dec 2001 15:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286369AbRLTU0N>; Thu, 20 Dec 2001 15:26:13 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:43464 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S286366AbRLTUZ6>;
	Thu, 20 Dec 2001 15:25:58 -0500
Message-ID: <3C224947.C73B00B9@rchland.vnet.ibm.com>
Date: Thu, 20 Dec 2001 14:25:44 -0600
From: David Engebretsen <engebret@vnet.ibm.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; AIX 4.3)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] PPC64 Architecture patch v2.5.1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

Attached is a pointer to a rather large patch which adds support
for PPC64 to the 2.5 tree.  It adds the include/asm-ppc64 and
arch/ppc64 directories, updates the Maintainers file, and updates
drivers/char/Config.in for ppc64 RTC support.

Linus, would you please add this to the 2.5 base?

ftp://master.penguinppc.org/users/engebret/linuxppc64-2.5.1-ibm-1.patch.gz

Thanks -

Dave Engebretsen
engebret@us.ibm.com



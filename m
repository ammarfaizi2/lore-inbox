Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVC0I5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVC0I5X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 03:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbVC0I5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 03:57:23 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:36043 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261478AbVC0I5U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 03:57:20 -0500
Date: Sun, 27 Mar 2005 10:57:13 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Aaron Gyes <floam@sh.nu>, linux-kernel@vger.kernel.org
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
In-Reply-To: <490243b66dc7c3f592df7a7d0769dcb7@mac.com>
Message-ID: <Pine.LNX.4.61.0503271052130.22393@yvahk01.tjqt.qr>
References: <1111886147.1495.3.camel@localhost> <490243b66dc7c3f592df7a7d0769dcb7@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BTW, to all you "But my drivers must be proprietary!" nerds out there,
> take a look at 3ware, Adaptec, etc.  They have _great_ hardware and yet
> they release all of their drivers under the GPL.  They get free updates
> to new kernel APIs too!

Well, it boils down to the full sourcecode. NVidia does only half.
Other good examples besides 3ware are: VMware kernel modules and
SUNWut/SRSS3 Linux Kernel modules.

Looks like there's only the GPU industry left that thinks somebody could 
"mis"use the kmod to make them (:one company) inferior on the market.


Jan Engelhardt
-- 
No TOFU for me, please.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271071AbTHLPjy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 11:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271051AbTHLPjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 11:39:53 -0400
Received: from ausadmmsps307.aus.amer.dell.com ([143.166.224.102]:61199 "HELO
	AUSADMMSPS307.aus.amer.dell.com") by vger.kernel.org with SMTP
	id S271055AbTHLPju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 11:39:50 -0400
X-Server-Uuid: 82a6c0aa-b49f-4ad3-8d2c-07dae6b04e32
Message-ID: <1060701718.1384.0.camel@localhost.localdomain>
From: Matt_Domsch@Dell.com
To: matthew.e.tolentino@intel.com
cc: mochel@osdl.org, metolent@snoqualmie.dp.intel.com,
       davidm@napali.hpl.hp.com, torvalds@osdl.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: RE: [patch] move efivars to drivers/efi
Date: Tue, 12 Aug 2003 10:21:51 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 1327D5CE2636994-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sure, I'll see if I can cook this up in the next few days and send an
> updated patch...

Great, thanks.  And to be clear, I'm happy to see efivars.c move to
drivers/efi.  Perhaps you can get that move done first, then do the
conversion to sysfs.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266806AbUGVIYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266806AbUGVIYe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 04:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266805AbUGVIYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 04:24:34 -0400
Received: from twix.hotpop.com ([38.113.3.71]:14826 "EHLO twix.hotpop.com")
	by vger.kernel.org with ESMTP id S266806AbUGVIYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 04:24:32 -0400
Subject: unresloved systems /drm/sis.o
From: "Joel n.solanki" <zealous@bonbon.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1090484680.2312.5.camel@joel.d2visp.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 22 Jul 2004 13:54:41 +0530
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel gurus..

My system is Redhat 9.0 
I have compiled 2.4.21 kernel downloaded from kernel.org
all things went good according to my choice.
But when doing make modules_install i got the error for Unresolved
sysmbols.

Result of depmod -a


[root@joel root]# depmod -a
depmod: *** Unresolved symbols in
/lib/modules/2.4.21/kernel/drivers/char/drm/sis.o


So what should i enable in this kernel so that i can not see error
again.
Searched for this error on google but cant find appropriate answer.
it says "SIS DRM requires SIS frame buffer, known problem"

but i didnt got solution from above sentence. i am very new to kernel
compilation.

Any ideas,

Regards,
Joel



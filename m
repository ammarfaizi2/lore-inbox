Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262198AbSJJUAf>; Thu, 10 Oct 2002 16:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262196AbSJJUA2>; Thu, 10 Oct 2002 16:00:28 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:53919 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262198AbSJJT7Q>; Thu, 10 Oct 2002 15:59:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: torvalds@transmeta.com
Subject: [PATCH] EVMS core (0/9)
Date: Thu, 10 Oct 2002 14:30:55 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-Id: <02101014305502.17770@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

On behalf of the EVMS team, I would like to submit the Enterprise Volume 
Management System for review and possible inclusion in the 2.5 kernel.

This submission includes only the core driver and include files. Additional 
plugins will be submitted in the future in separate patches.

This series of patches contains the following files:
1) evms.c
2) services.c
3) discover.c
4) passthru.c
5) evms_core.h
6) evms.h
7) evms_ioctl.h
8) evms_biosplit.h
9) miscellaneous files

If you are interested in other information about EVMS, or would
like to obtain the user-space administration tools, please visit
our website at http://evms.sourceforge.net/.

Thank you very much for taking the time to review this submission. If you 
have any questions or comments, please email us at any time. We will be happy 
to do whatever is necessary to make EVMS acceptable for inclusion in the 2.5 
tree.

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/

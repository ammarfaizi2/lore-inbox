Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbVIOMFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbVIOMFI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 08:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbVIOMFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 08:05:08 -0400
Received: from f47.mail.ru ([194.67.57.83]:47889 "EHLO f47.mail.ru")
	by vger.kernel.org with ESMTP id S1751145AbVIOMFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 08:05:07 -0400
From: Serge Goodenko <s_goodenko@mail.ru>
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [194.85.70.42]
Date: Thu, 15 Sep 2005 16:05:00 +0400
Reply-To: Serge Goodenko <s_goodenko@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1EFsU8-000LYB-00.s_goodenko-mail-ru@f47.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello again!

continuing exploring linux kernel networking...
in function sys_socketcall() why cannot I read using gdb the message being transmitted in args[] array (i suppose it must be in (char*)args[1])
I cannot do it neither before copy_from_user() (directly from (char*)args[1])
nor after (from a1 variable)
at long last, where is that dear message??????

using UML kernel 2.4.25 and gdb

thank you

Serge
MIPT, Russia



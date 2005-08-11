Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbVHKOnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbVHKOnA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 10:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbVHKOnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 10:43:00 -0400
Received: from mail.gmx.de ([213.165.64.20]:25735 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751056AbVHKOm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 10:42:59 -0400
Date: Thu, 11 Aug 2005 16:42:58 +0200 (MEST)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: trond.myklebust@fys.uio.no, peterc@gelato.unsw.edu.au,
       linux-kernel@vger.kernel.org, sfr@canb.auug.org.au, matthew@wil.cx,
       michael.kerrisk@gmx.net
MIME-Version: 1.0
References: <20050811142047.GE10030@fieldses.org>
Subject: =?ISO-8859-1?Q?Re:_fcntl(F_GETLEASE)_semantics=3F=3F?=
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <31857.1123771378@www9.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Von: "J. Bruce Fields" <bfields@fieldses.org>

> In any case, I haven't seen a real argument for reverting to the old
> behaviour.  I'd rather see an established standard, or a correct
                                ^^^^^^^^^^^^^^^^^^^^
> real-world application that fails, not just some arbitrary test.

Agreed -- though I'd phrase it as "documented specification".

Cheers,

Michael

-- 
5 GB Mailbox, 50 FreeSMS http://www.gmx.net/de/go/promail
+++ GMX - die erste Adresse für Mail, Message, More +++

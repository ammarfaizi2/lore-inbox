Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264285AbTLEPDJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 10:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbTLEPDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 10:03:09 -0500
Received: from imap.gmx.net ([213.165.64.20]:5523 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264285AbTLEPDH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 10:03:07 -0500
Date: Fri, 5 Dec 2003 16:03:04 +0100 (MET)
From: "Peter Bergmann" <bergmann.peter@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: nfedera@esesix.at
MIME-Version: 1.0
Subject: old oom-vm for 2.4.32 (was oom killer in 2.4.23)
X-Priority: 3 (Normal)
X-Authenticated: #13246506
Message-ID: <6021.1070636584@www2.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If anyone  is interested:
Norbert Federa sent me this link for a "quick&dirty" patch he made 
for 2.4.23-vanilla which rolls back the complete 2.4.22 vm including the
old oom-killer  - without guarantee but it does work very well for me ...

http://www.esesix.at/kernel/vm-2.4.22.diff
http://www.esesix.at/kernel/vm-2.4.22.diff.gz

-- 
+++ GMX - die erste Adresse für Mail, Message, More +++
Neu: Preissenkung für MMS und FreeMMS! http://www.gmx.net



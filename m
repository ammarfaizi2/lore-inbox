Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266905AbUBMKu2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 05:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266906AbUBMKu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 05:50:28 -0500
Received: from mail.gmx.de ([213.165.64.20]:23968 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266905AbUBMKu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 05:50:27 -0500
Date: Fri, 13 Feb 2004 11:50:26 +0100 (MET)
From: "Daniel Blueman" <daniel.blueman@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: update used the obsolete bdflush
X-Priority: 3 (Normal)
X-Authenticated: #8973862
Message-ID: <12021.1076669426@www11.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/sbin/update is being started from your /etc/inittab.

This was deprecated quite a while ago, and more recently, a warning
added. Just remove the line from inittab.

"J.A. Magallon" <jamagallon@able.es> wrote in message
news:<1ozdQ-5EI-3@gated-at.bofh.it>...
> Hi all...
>
> I get this in syslog:

-- 
Daniel J Blueman

GMX ProMail (250 MB Mailbox, 50 FreeSMS, Virenschutz, 2,99 EUR/Monat...)
jetzt 3 Monate GRATIS + 3x DER SPIEGEL +++ http://www.gmx.net/derspiegel +++


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbULNMNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbULNMNZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 07:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbULNMNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 07:13:24 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:21465 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261485AbULNMNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 07:13:21 -0500
To: ram mohan <madhaviram123@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux - open design??
References: <20041214040125.70151.qmail@web90010.mail.scd.yahoo.com>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Tue, 14 Dec 2004 13:13:09 +0100
Message-ID: <87u0qpgjsa.fsf@goat.bogus.local>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ram mohan <madhaviram123@yahoo.com> writes:

> When we say Linux is open source and we have the sites
> where we can download the source from, why is not
> linux design (High Level and Low Level) not that well
> publicised? (Or is it that I am not aware of - in
> which case I would like to know where it is.)
> I am looking for a traceability matrix- where I start
> with requirements of Linux, dig into the
> design(HLD/LLD) and then the source.

There's no high level overview, AFAIK. But there are many documents
out there, describing various parts of Linux. Many of them are
outdated, but you can get an idea, how Linux works.

Linux Kernel 2.4 Internals <http://www.tldp.org/LDP/lki/>
Linux Kernel Hackers' Guide <http://www.tldp.org/LDP/khg/>
Linux Memory Management: <http://www.linux-mm.org/>
The Linux Kernel API <http://kernelnewbies.org/documents/kdoc/kernel-api/linuxkernelapi.html>
The Linux Kernel (based on 2.0.33) <http://www.tldp.org/LDP/tlk/>

and all below linux/Documentation, of course. However, if you want to
learn about the current state of Linux, you won't get around reading
the source.

Regards, Olaf.

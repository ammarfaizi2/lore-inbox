Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbVKPIMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbVKPIMw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 03:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbVKPIMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 03:12:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:3563 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030219AbVKPIMv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 03:12:51 -0500
Date: Wed, 16 Nov 2005 09:12:50 +0100 (MET)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, mtk-manpages@gmx.net
MIME-Version: 1.0
References: <20051115173307.GB13707@suse.de>
Subject: Re: [RFC] HOWTO do Linux kernel development
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <711.1132128770@www71.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

Under 'Documentation', there is the text:

    When new features are added to the kernel, it is recommended 
    that new documentation files are also added which explain how 
    to use the feature.

Could you also add something like:

    When a new feature changes the interface that the kernel 
    exposes to userland, it is recommended that you send 
    information or a man-pages patch explaining the change 
    to the manual pages maintainer at mtk-manpages@gmx.net.

Thanks,

Michael

-- 
10 GB Mailbox, 100 FreeSMS/Monat http://www.gmx.net/de/go/topmail
+++ GMX - die erste Adresse für Mail, Message, More +++

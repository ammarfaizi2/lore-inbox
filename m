Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030312AbVIVNK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030312AbVIVNK3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 09:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030310AbVIVNK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 09:10:29 -0400
Received: from pop.gmx.de ([213.165.64.20]:1491 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030312AbVIVNK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 09:10:28 -0400
Date: Thu, 22 Sep 2005 15:10:26 +0200 (MEST)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: "Michael Kerrisk" <mtk-lkml@gmx.net>
Cc: mingo@elte.hu, roland@redhat.com, linux-kernel@vger.kernel.org,
       michael.kerrisk@gmx.net
MIME-Version: 1.0
References: <20206.1127391230@www22.gmx.net>
Subject: Re: Process with many NPTL threads terminates slowly on core dump signal
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <5012.1127394626@www51.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just one further point to my ealier report.  Some investigation 
shows that the problem seems to have appaeared with kernel 2.6.11.

Cheers,

Michael

-- 
Lust, ein paar Euro nebenbei zu verdienen? Ohne Kosten, ohne Risiko!
Satte Provisionen für GMX Partner: http://www.gmx.net/de/go/partner

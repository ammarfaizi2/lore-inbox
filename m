Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136077AbRD0PEX>; Fri, 27 Apr 2001 11:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136074AbRD0PEN>; Fri, 27 Apr 2001 11:04:13 -0400
Received: from vill.ha.smisk.nu ([212.75.83.8]:36110 "HELO mail.fbab.net")
	by vger.kernel.org with SMTP id <S136073AbRD0PDz>;
	Fri, 27 Apr 2001 11:03:55 -0400
X-Qmail-Scanner-Mail-From: mag@fbab.net via mail.fbab.net
X-Qmail-Scanner-Rcpt-To: andrea@suse.de linux-kernel@vger.kernel.org
X-Qmail-Scanner: 0.94 (No viruses found. Processed in 8.233533 secs)
Message-ID: <017701c0cf2b$06783b20$020a0a0a@totalmef>
From: "Magnus Naeslund\(f\)" <mag@fbab.net>
To: "Andrea Arcangeli" <andrea@suse.de>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <052901c0ceca$e6a543c0$020a0a0a@totalmef> <20010427155246.O16020@athlon.random>
Subject: Re: Alpha compile problem solved by Andrea (pte_alloc)
Date: Fri, 27 Apr 2001 17:02:06 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Andrea Arcangeli" <andrea@suse.de>

[snip]

> > Is there any other patches you recommend me to apply to my kernel?
>
> specifically for the alpha (but of course ok for x86 kernels too) in
> order against pre7:
>
>
ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.4pre
7aa1/00_alpha-numa-6
>
ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.4pre
7aa1/00_numa-sched-5
>
ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.4pre
7aa1/00_alpha-tlb-page-sym-1
>
ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.4pre
7aa1/00_softirq-SMP-fixes-2
>
ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.4pre
7aa1/00_rwsem-10
>
> Andrea
>

Thanks...
Will apply them..

Magnus


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289628AbSAJTTJ>; Thu, 10 Jan 2002 14:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289636AbSAJTS4>; Thu, 10 Jan 2002 14:18:56 -0500
Received: from mail.scs.ch ([212.254.229.5]:43197 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id <S289629AbSAJTQs>;
	Thu, 10 Jan 2002 14:16:48 -0500
Message-ID: <3C3DE898.9090909@scs.ch>
Date: Thu, 10 Jan 2002 20:16:40 +0100
From: Markus Walser <walser@scs.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18pre2aa2
In-Reply-To: <20020109184413.A2289@inspiron.school.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
It looks like in net/sunrpc/stats.c is a #include <linux/init.h> missing.

Regards, Markus

>Minor pending changes.
>
>URL:
>
>	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.18pre2aa2.bz2
>	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.18pre2aa2/
>
>Only in 2.4.18pre2aa2/: 00_nfs-rdplus-1
>Only in 2.4.18pre2aa2/: 00_nfs-svc_tcp-1
>Only in 2.4.18pre2aa2/: 00_nfs-tcp-tweaks-1
>
>	NFS updates from Trond.
>
>Only in 2.4.18pre2aa1: 30_dyn-sched-1
>Only in 2.4.18pre2aa2/: 30_dyn-sched-2
>
>	A few minor implementation optimizations from Davide and
>	handle gracefully a negative 'rcl_curr - p->rcl_last'.
>
>Andrea
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


-- 
________________________________________________________

Supercomputing Systems AG       email: walser@scs.ch
Markus Walser                   web:   http://www.scs.ch
Technoparkstrasse 1             phone: +41 1 445 16 00
CH-8005 Zuerich                 fax:   +41 1 445 16 10




Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129908AbQLSP0P>; Tue, 19 Dec 2000 10:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129950AbQLSP0F>; Tue, 19 Dec 2000 10:26:05 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:48906 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129908AbQLSPZw>;
	Tue, 19 Dec 2000 10:25:52 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200012191454.RAA13529@ms2.inr.ac.ru>
Subject: Re: ip_defrag / ip_conntrack issues (was Re: [PATCH] Fix netfilter
To: davem@redhat.com (David S. Miller)
Date: Tue, 19 Dec 2000 17:54:35 +0300 (MSK)
Cc: tleete@mountain.net, laforge@gnumonks.org, rusty@linuxcare.com.au,
        netfilter-devel@us5.samba.org, linux-kernel@vger.kernel.org
In-Reply-To: <200012191412.GAA06310@pizda.ninka.net> from "David S. Miller" at Dec 19, 0 06:12:39 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> able to lockup/OOPS his machine by logging into X as a user who had
> his home directory over NFS. 

I believe this report is to be ignored. It is fully meaningless.
X has nothing to do with NFS, NFS is with X, and defragmenter is
at least with one of them.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

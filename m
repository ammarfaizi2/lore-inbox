Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135232AbQLNXLC>; Thu, 14 Dec 2000 18:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135233AbQLNXKs>; Thu, 14 Dec 2000 18:10:48 -0500
Received: from raven.toyota.com ([205.180.183.200]:18948 "EHLO
	raven.toyota.com") by vger.kernel.org with ESMTP id <S133089AbQLNXKY>;
	Thu, 14 Dec 2000 18:10:24 -0500
Message-ID: <3A394C2F.C2895995@toyota.com>
Date: Thu, 14 Dec 2000 14:39:43 -0800
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [lkml]Re: VM problems still in 2.2.18
In-Reply-To: <E146h1W-000081-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > slrnpull --expire on a news-spool of about 600 Mb in 200,000 files gave
> > a lot of 'trying_to_free..' errors.
> >
> > 2.2.18 + VM-global, booted with mem=32M:
> >
> > slrnpull --expire on the same spool worked fine.
>
> I think Andrea just earned his official God status ;)

So, maybe his divine VM patches will make it into 2.2.19?

jjs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

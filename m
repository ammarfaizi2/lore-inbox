Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264329AbRGIRpL>; Mon, 9 Jul 2001 13:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264345AbRGIRpB>; Mon, 9 Jul 2001 13:45:01 -0400
Received: from pop.gmx.net ([194.221.183.20]:7117 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S264329AbRGIRov>;
	Mon, 9 Jul 2001 13:44:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas =?iso-8859-1?q?M=F6ller?= <andreas-moeller@gmx.net>
To: Felix Braun <Felix.Braun@McGill.ca>
Subject: Re: Random lockups with kernels 2.4.6-pre8+
Date: Mon, 9 Jul 2001 19:44:47 +0200
X-Mailer: KMail [version 1.2.9]
In-Reply-To: <Pine.LNX.4.33L2.0107080056170.833-100000@eressea.in-berlin.de>
In-Reply-To: <Pine.LNX.4.33L2.0107080056170.833-100000@eressea.in-berlin.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Cc: linux-kernel@vger.kernel.org
Message-Id: <20010709174456Z264329-720+528@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 8. Juli 2001 07:01 schrieb Felix Braun:
> Hi there,
>
> just in case anybody cares: the lockup behaviour that I observed starting
> mozilla 0.9.2 on kernels 2.4.6-pre8 and 2.4.6-final does not occur on
> 2.4.6-ac2 (haven't tried with 2.4.7-preX). Appearently, I was the only one
> experiencing that problem anyway. Ah well, I won't complain now that
> evertything is working.

I also experienced some lockups under 2.4.6-pre, there was an OOPS under 
2.4.6-pre3 and some other lockups under newer 2.4.6-pres but without any 
error message. Each time I was running Mozilla 0.9.1 (respectively Galeon 
0.11.0). Fortunately, there were no more lockups since 2.4.7-pre (I didn't 
test 2.4.6 abundant).

>
> Cheers Felix
>

	Andreas

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130030AbRAGJoo>; Sun, 7 Jan 2001 04:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130069AbRAGJof>; Sun, 7 Jan 2001 04:44:35 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:41706 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S130030AbRAGJoV>; Sun, 7 Jan 2001 04:44:21 -0500
Date: Sun, 7 Jan 2001 10:44:43 +0100 (CET)
From: Matthias Juchem <matthias@gandalf.math.uni-mannheim.de>
Reply-To: Matthias Juchem <juchem@uni-mannheim.de>
To: Brett <bpemberton@dingoblue.net.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new bug report script
In-Reply-To: <Pine.LNX.4.21.0101072041380.12767-100000@tae-bo.generica.dyndns.org>
Message-ID: <Pine.LNX.4.30.0101071040250.7104-100000@gandalf.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2001, Brett wrote:

> Taking a guess here....
>
> strings /lib/libc* | grep "release version"
>
> I'm not sure how reliable this method is either :)
>

I guess if you use a development version the above returns nothing. If I'm
right, a pre-release libc was recommended for use with 2.2.0 (I'm not
sure).

Matthias

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKFJtG>; Mon, 6 Nov 2000 04:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129038AbQKFJsq>; Mon, 6 Nov 2000 04:48:46 -0500
Received: from [62.172.234.2] ([62.172.234.2]:23179 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S129033AbQKFJsp>;
	Mon, 6 Nov 2000 04:48:45 -0500
Date: Mon, 6 Nov 2000 09:49:10 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Rainer Mager <rmager@vgkk.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS when using 4GB memory setting
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGIEBCCHAA.rmager@vgkk.com>
Message-ID: <Pine.LNX.4.21.0011060946180.11361-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, Rainer Mager wrote:
> 	I have 2 intertwined problems that my initial web research has failed to
> reveal help. I recently upgraded machines and the new one has 1GB RAM. If I
> build a 2.4.0pre10 (or 8 or 9, I haven't tried earlier) kernel and chose the

there is no such thing yet. 2.4.0 has not yet approached the "preX" cycle
but is currently in "textX" cycle and each testX internally contains lots
of "preY", of course. So, we have kernels test9,test10-pre1,test10 etc.

I assume you are talking about test10 kernel as it is the latest and there
is never any reason to run a development kernel except the latest.

> 	So, is this a known issue? Should I do an oops analysis? What can I do to
> fix this?

of course you should do an oops analysis. Without it, your email is not
very useful.

Regards,
Tigran


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

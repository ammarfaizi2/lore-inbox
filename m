Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129985AbRAQJnq>; Wed, 17 Jan 2001 04:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131620AbRAQJng>; Wed, 17 Jan 2001 04:43:36 -0500
Received: from stud3.tuwien.ac.at ([193.170.75.13]:17163 "EHLO
	stud3.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S129985AbRAQJnV>; Wed, 17 Jan 2001 04:43:21 -0500
Date: Wed, 17 Jan 2001 10:43:13 +0100 (MET)
From: Stefan Ring <e9725446@student.tuwien.ac.at>
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.0.37 crashes immediately
In-Reply-To: <Pine.LNX.4.31.0101162302550.722-100000@asdf.capslock.lan>
Message-ID: <Pine.HPX.4.10.10101171041430.18039-100000@stud3.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Holy ancient and unsupported kernel + distribution batman.  ;o)
> 
> Have you tried 2.0.39 (said with a slight grin)  ;o)

Ahh, it was my fault. I forgot about binutils. Strange enough, 2.0.36
worked and 2.0.37 not. There is no change to the Changes file between
these two versions, however.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

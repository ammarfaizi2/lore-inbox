Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129255AbQKUCiY>; Mon, 20 Nov 2000 21:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129295AbQKUCiP>; Mon, 20 Nov 2000 21:38:15 -0500
Received: from nat.dmz.icopyright.com ([209.191.160.234]:22261 "EHLO
	enki.corp.icopyright.com") by vger.kernel.org with ESMTP
	id <S129255AbQKUCh6>; Mon, 20 Nov 2000 21:37:58 -0500
Date: Mon, 20 Nov 2000 18:06:56 -0800 (PST)
From: <lamont@icopyright.com>
To: Andrew Morton <andrewm@uow.edu.au>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Negative scalability by removal of
In-Reply-To: <3A07FB88.E73D0D2D@uow.edu.au>
Message-ID: <Pine.LNX.4.21.0011201804570.4623-100000@enki.corp.icopyright.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


there's already the Linux Scalability Project's wake_one() patch for 2.2.9
(which applies fine to 2.2.18preX):

http://www.citi.umich.edu/projects/linux-scalability/patches/p_accept-2.2.9.diff



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

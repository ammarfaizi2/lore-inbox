Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262504AbREZBkS>; Fri, 25 May 2001 21:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262515AbREZBkI>; Fri, 25 May 2001 21:40:08 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:45414 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S262504AbREZBj5>; Fri, 25 May 2001 21:39:57 -0400
Date: Fri, 25 May 2001 21:39:36 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.5
In-Reply-To: <Pine.LNX.4.31.0105251826290.1126-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0105252138550.3806-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, this doesn't fix the problem.  It still hangs on highmem machines.
Try running cerberus on a PAE kernel sometime.

		-ben

On Fri, 25 May 2001, Linus Torvalds wrote:

> Ok, I applied Andrea's (nee Ingo's) version, as that one most clearly
> attacked the real deadlock cause. It's there as 2.4.5 now.
>
> I'm going to be gone in Japan for the next week (leaving tomorrow
> morning), so please don't send me patches - I won't be able to react to
> them anyway. Consider the -ac series and the kernel mailing list the
> regular communications channels..
>
> Thanks,
>
> 		Linus
>


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129655AbQKFSj7>; Mon, 6 Nov 2000 13:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129653AbQKFSjt>; Mon, 6 Nov 2000 13:39:49 -0500
Received: from [193.120.224.170] ([193.120.224.170]:14736 "EHLO
	florence.itg.ie") by vger.kernel.org with ESMTP id <S129597AbQKFSjh>;
	Mon, 6 Nov 2000 13:39:37 -0500
Date: Mon, 6 Nov 2000 18:39:22 +0000 (GMT)
From: Paul Jakma <paulj@itg.ie>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "James A. Sutherland" <jas88@cam.ac.uk>,
        David Woodhouse <dwmw2@infradead.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, Dan Hollis <goemon@anime.net>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <E13spou-0006P0-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0011061837590.31802-100000@rossi.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, Alan Cox wrote:

> Which is part of what persistent module data lets you do. And without having
> to mess with dont_screw_with_mixer (which if you get it wrong btw can be 
> fatal and hang the hardware)
> 

the sound card case for persistent modules is contentious i think.

what other good reasons are there for persistent data?

--paulj

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130133AbQLFAwe>; Tue, 5 Dec 2000 19:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130397AbQLFAwZ>; Tue, 5 Dec 2000 19:52:25 -0500
Received: from xerxes.thphy.uni-duesseldorf.de ([134.99.64.10]:33515 "EHLO
	xerxes.thphy.uni-duesseldorf.de") by vger.kernel.org with ESMTP
	id <S130133AbQLFAwM>; Tue, 5 Dec 2000 19:52:12 -0500
Date: Wed, 6 Dec 2000 01:21:34 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: That horrible hack from hell called A20
In-Reply-To: <3A2D7AA4.9E7D414F@transmeta.com>
Message-ID: <Pine.LNX.4.10.10012060118580.5125-100000@chaos.thphy.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 5 Dec 2000, H. Peter Anvin wrote:

> If you have had A20M# problems with any kernel -- recent or not --
> *please* try this patch, against 2.4.0-test12-pre5:

Just a datapoint: This patch doesn't fix the problem here (Sony
PCG-Z600NE). Still the spontaneous reboot exactly the moment I expect to
get my console back from resumeing.

--Kai


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

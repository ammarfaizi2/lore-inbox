Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131463AbRAXVFs>; Wed, 24 Jan 2001 16:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131999AbRAXVFi>; Wed, 24 Jan 2001 16:05:38 -0500
Received: from d-dialin-134.addcom.de ([62.96.159.142]:64245 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S131463AbRAXVF3>; Wed, 24 Jan 2001 16:05:29 -0500
Date: Wed, 24 Jan 2001 22:06:47 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: Kai Henningsen <kaih@khms.westfalen.de>
cc: <linux-kernel@vger.kernel.org>, <isdn4linux@listserv.isdn4linux.de>
Subject: Re: ipppd == pppd?
In-Reply-To: <7u7jt7x1w-B@khms.westfalen.de>
Message-ID: <Pine.LNX.4.30.0101242205450.10925-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jan 2001, Kai Henningsen wrote:

> > This info is just plain wrong. Unfortunately, ISDN syncPPP isn't using the
> > generic PPP layer yet.
> 
> So, is this still planned? Any sort of timeline?

Yes, however, it's always planned to dump the old ISDN link layer at some 
point and switch over to a CAPI based system. There's not really a 
timeline yet.

--Kai


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

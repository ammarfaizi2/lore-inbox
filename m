Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131620AbRAOWM1>; Mon, 15 Jan 2001 17:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131617AbRAOWMH>; Mon, 15 Jan 2001 17:12:07 -0500
Received: from d-dialin-1772.addcom.de ([62.96.166.92]:18670 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S131363AbRAOWL7>; Mon, 15 Jan 2001 17:11:59 -0500
Date: Mon, 15 Jan 2001 23:12:54 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: Kai Henningsen <kaih@khms.westfalen.de>
cc: <linux-kernel@vger.kernel.org>, <isdn4linux@listserv.isdn4linux.de>,
        <pranevich@lycos.com>
Subject: Re: ipppd == pppd? (was: Re: New features in Linux 2.4 - Wonderful
 Wor...)
In-Reply-To: <7tn2wlMmw-B@khms.westfalen.de>
Message-ID: <Pine.LNX.4.30.0101152310580.2419-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Jan 2001, Kai Henningsen wrote:

> jpranevich@lycos.com (Joe Pranevich)  wrote on 06.01.01 in <CNDCNNNONGMAFAAA@mailcity.com>:
>
> >    much of the code, including a long awaited combination of the PPP
> >    layers from the ISDN layer and the serial device PPP layer, such as
>
> I've heard about that before, but I can find no hint about that in
> Documentation/. The separate ipppd is still mentioned there.
>
> Plus, looking at the ISDN PPP sources also gives no hint.
>
> What's up?

This info is just plain wrong. Unfortunately, ISDN syncPPP isn't using the
generic PPP layer yet.

--Kai


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

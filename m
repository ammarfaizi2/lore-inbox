Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318830AbSHSNEx>; Mon, 19 Aug 2002 09:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318877AbSHSNEx>; Mon, 19 Aug 2002 09:04:53 -0400
Received: from [203.197.212.137] ([203.197.212.137]:48289 "EHLO
	dns3.ggn.hcltech.com") by vger.kernel.org with ESMTP
	id <S318830AbSHSNEw>; Mon, 19 Aug 2002 09:04:52 -0400
Message-ID: <5F0021EEA434D511BE7300D0B7B6AB5303C78756@mail2.ggn.hcltech.com>
From: "Mohamed Ghouse , Gurgaon" <MohamedG@ggn.hcltech.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       Sirius Black <sirius_ml@shellfreaks.cx>
Cc: linux-kernel@vger.kernel.org
Subject: RE: max open file descriptors
Date: Mon, 19 Aug 2002 18:41:33 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can I know the limit for 2.2?

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Monday, August 19, 2002 5:31 PM
To: Sirius Black
Cc: linux-kernel@vger.kernel.org
Subject: Re: max open file descriptors


On Mon, 2002-08-19 at 11:37, Sirius Black wrote:
> Hi to all,
> 
> I was wondering on how much the FD limit can be increased
> whitout having any problems; i've searched on the net and found 
> some docs which says 2048 and others 4096....
> 
> Which is the maximum number of open FD can i set?

For 2.2 there are real per process limitations, for 2.4 it basically
depends how much RAM you have

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

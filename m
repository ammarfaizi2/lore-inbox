Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129573AbRAELPo>; Fri, 5 Jan 2001 06:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129675AbRAELPf>; Fri, 5 Jan 2001 06:15:35 -0500
Received: from [209.58.33.70] ([209.58.33.70]:59921 "EHLO ns1.sdnpk.org")
	by vger.kernel.org with ESMTP id <S129573AbRAELP0>;
	Fri, 5 Jan 2001 06:15:26 -0500
Message-ID: <3A55AC79.87383BF3@khi.sdnpk.org>
Date: Fri, 05 Jan 2001 16:14:01 +0500
From: Mike <mike@khi.sdnpk.org>
X-Mailer: Mozilla 4.61 [en] (Win95; I)
X-Accept-Language: en
MIME-Version: 1.0
To: "J . A . Magallon" <jamagallon@able.es>
CC: "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>,
        "linux-irda @ pasta . cs . UiT . No" <linux-irda@pasta.cs.UiT.No>
Subject: Re: INIT: No inittab file found
In-Reply-To: <3A548636.27C231BA@khi.sdnpk.org> <20010104224837.C1148@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried linux single but it says " no such image"

Actually someone hacked my linux box and now i can't boot it. Can somone help
me.


"J . A . Magallon" wrote:

> On 2001.01.04 Mike wrote:
> > Hi,
> >
> > I am unable to boot my linux. I got the following message during boot.
> >
> > ====================================================
> > INIT: No inittab file found
> > INIT: Can't open(/etc/ioctl.save, O_WRONLY): No such file or directory
> >
> > Enter Runlevel:
> > =====================================================
> >
>
> Try answering 'single'. That boots into 'single user mode': no
> daemons, no try to load inittab. Just a shell to let you check if
> there exists an /etc/inittab file.
>
> --
> J.A. Magallon                                         $> cd pub
> mailto:jamagallon@able.es                             $> more beer
>
> Linux werewolf 2.2.19-pre6 #1 SMP Wed Jan 3 21:28:10 CET 2001 i686
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

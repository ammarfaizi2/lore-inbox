Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261629AbREUR0t>; Mon, 21 May 2001 13:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261634AbREUR0j>; Mon, 21 May 2001 13:26:39 -0400
Received: from 24.68.61.66.on.wave.home.com ([24.68.61.66]:27411 "HELO
	sh0n.net") by vger.kernel.org with SMTP id <S261629AbREUR0S>;
	Mon, 21 May 2001 13:26:18 -0400
Date: Mon, 21 May 2001 13:26:46 -0400 (EDT)
From: Shawn Starr <spstarr@sh0n.net>
To: Keith Owens <kaos@ocs.com.au>
cc: Allan Duncan <b372050@vus068.trl.telstra.com.au>,
        <linux-kernel@vger.kernel.org>
Subject: Re: compile failure in 2.4.5-pre4 
In-Reply-To: <1380.990427665@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.30.0105211326380.15779-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, so the code was easy to fix ;p

On Mon, 21 May 2001, Keith Owens wrote:

> On Mon, 21 May 101 16:38:45 +1000 (EST),
> Allan Duncan <b372050@vus068.trl.telstra.com.au> wrote:
> >drivers/ide/ide-pci.c:711
> >    		if (!IDE_PCI_DEVID_EQ(d->devid, DEVID_CS5530)
>
> for (i = 0; i < 1000; ++i)
>   printf("I must scan kernel archives before report bugs\n");
>
> http://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg45470.html
>
> >Allan Duncan  b372050@vus068.trl.telstra.com.au  (+613) 9253 6708, Fax 9253 6775
> >     (We are just a number)
>
> Who is number 1?
> You are number 6.
> I am not a number, I am a free man!
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270990AbRHTBgM>; Sun, 19 Aug 2001 21:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270992AbRHTBgD>; Sun, 19 Aug 2001 21:36:03 -0400
Received: from warden.digitalinsight.com ([208.29.163.2]:15859 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S270990AbRHTBfr>; Sun, 19 Aug 2001 21:35:47 -0400
From: David Lang <david.lang@digitalinsight.com>
To: tristan <fattymikefx@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Date: Sun, 19 Aug 2001 17:18:36 -0700 (PDT)
Subject: Re: installing Linux over a network
In-Reply-To: <20010820012137.8E169501DB@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0108191714210.798-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

with slackware you need to NFS export the slakware directory from the CD
on one machine.

with slackware 8

the on the 386 boot from the boot disk, then the root disk, then type
network and put in the network driver floppy. when the NIC is detected
then go through the setup menu and choose the 'install from nfs' option.

e-mail me directly if you have more questions, this is now off-topic for
this list.

David Lang

On Sun, 19 Aug 2001, tristan wrote:

> Date: Sun, 19 Aug 2001 21:21:37 -0400
> From: tristan <fattymikefx@yahoo.com>
> To: linux-kernel@vger.kernel.org
> Subject: installing Linux over a network
>
> I havent been able to find a way of installing
> Linux slackware or red hat with out using 90 or more
> floppies, and i have no cd rom on my 386. Is there
> a way to install Linux over a network on such an old machine.
> It currently has windows 3.1 and DOS running. And
> has one 60 mb hard drive and one 120 mb hard drive.
> I have found a small easy to install minix 386 that goes over
> DOS so I may just use that to start off, in order to install
> a very old linux kernel .01 or .02
>
> Tristan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

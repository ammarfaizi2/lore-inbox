Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbSJZGqx>; Sat, 26 Oct 2002 02:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261900AbSJZGqx>; Sat, 26 Oct 2002 02:46:53 -0400
Received: from smtp09.wxs.nl ([195.121.6.38]:62643 "EHLO smtp09.wxs.nl")
	by vger.kernel.org with ESMTP id <S261894AbSJZGqx>;
	Sat, 26 Oct 2002 02:46:53 -0400
Message-ID: <001401c27cbc$53ecf810$1400a8c0@Freaky>
From: "freaky" <freaky@bananateam.nl>
To: <linux-kernel@vger.kernel.org>
References: <007501c27c5d$378aef10$1400a8c0@Freaky><1035580299.13244.82.camel@irongate.swansea.linux.org.uk> <000c01c27c6a$fe2e9b00$1400a8c0@Freaky> <1035582704.12995.91.camel@irongate.swansea.linux.org.uk>
Subject: Re: KT333, IO-APIC, Promise Fasttrak, Initrd
Date: Sat, 26 Oct 2002 08:53:02 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 2002-10-25 at 22:10, freaky wrote:
> > No problems under XP so far...what kind of blocks would that be? Only
had
> > time-outs on one of the disks when it was only slave (no master present
> > forgot to attach it :/) but since the master is attached that's gone....
all
> > my old data plays fine, mainly mp3's, games and movies.
>
> The HPT and Promise raid cards add extra partition table type data of
> their own identifying each volume. Their drivers then read and honour
> that info.

So that would be data on the MBR, or partition table? Perhaps win doesn't
have probs because it can handle to partitions types properly. MSI told me
themselves the trick would work (so I guess it might support to run as IDE
controller but to save money they didn't include the jumper thingy.... I'll
try contacting promise on this one, I tried that once before with the
time-outs but no replies. :-().

> > I'll supply all of the info later, low on time now and it's late. Want
the
> > kernel config and such as well? BIOS setup?
>
> If it looks useful include it 8)

Sure. But since I can't boot, err ok it boots but no shell :-( it won't be
all that much

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292395AbSCMGD4>; Wed, 13 Mar 2002 01:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292398AbSCMGDr>; Wed, 13 Mar 2002 01:03:47 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:33809 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S292395AbSCMGDc>; Wed, 13 Mar 2002 01:03:32 -0500
Date: Tue, 12 Mar 2002 22:03:30 -0800 (PST)
From: Jauder Ho <jauderho@carumba.com>
X-X-Sender: jauderho@twinlark.arctic.org
To: walter <walt@nea-fast.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: oracle rmap kernel version
In-Reply-To: <200203121729.MAA08522@int1.nea-fast.com>
Message-ID: <Pine.LNX.4.44.0203122202580.28876-100000@twinlark.arctic.org>
X-Mailer: UW Pine 4.44 + a bunch of schtuff
X-There-Is-No-Hidden-Message-In-This-Email: There are no tyops either
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Has anyone done any comparisons of Oracle performance on Linux/Intel vs
Solaris/Sun?

--Jauder


On Tue, 12 Mar 2002, walter wrote:

> Does anyone have any production experience running Oracle 8i on Linux? I've
> run it at home, RH 7.2 with vanilla 2.4.16 kernel all IDE drives, and its
> fast. We are replacing our SUN/Oracle 8 servers at work in next couple of
> months with Linux/Oracle 8i (Pentium 4 1GB ram).  My question is, what is the
> best kernel version to use,  vanilla 2.4.x or a RH kernel built from the ac
> tree with rmap. All drives will be SCSI.
> I read an interview yesterday with Rik van Riel where he said rmap worked
> better for db servers but I expect that he is partial to rmap 8-).
> Our web servers are running vanilla 2.4.16 and we haven't had a problem yet
> (knock on wood).
>
> Thanks !
> --
> Walter Anthony
> System Administrator
> National Electronic Attachment
> "If it's not broke....tweak it"
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


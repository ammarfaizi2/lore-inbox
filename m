Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285023AbRLXOxS>; Mon, 24 Dec 2001 09:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285024AbRLXOxI>; Mon, 24 Dec 2001 09:53:08 -0500
Received: from Expansa.sns.it ([192.167.206.189]:37906 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S285023AbRLXOxE>;
	Mon, 24 Dec 2001 09:53:04 -0500
Date: Mon, 24 Dec 2001 15:53:28 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Juergen Sauer <jojo@automatix.de>
cc: Hans Reiser <reiser@namesys.com>, bil Jeschke <theuteck@yahoo.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Reaiser fs
In-Reply-To: <E16IVIq-0005C3-00@s.automatix.de>
Message-ID: <Pine.LNX.4.33.0112241550450.13979-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using NFS to share /usr and /home with reiserFS on three dual Athlon
1500XP, and they have 1 month of uptime and no problems till now.
I am using kernel 2.4.13+mosix. I am also using a 2.4.17 NFS server with
reiserFS on a k6-II 475Mhz, for slackware installation with NFS, and no
problem also there. It happens that I have also very high IO on NFS, so I
think I can say it works.

Luigi

On Mon, 24 Dec 2001, Juergen Sauer wrote:

> > ReiserFS is not labelled experimental in the SuSE kernel nowadays......
> > and I think SuSE is correct.  We still have bugs, you can read about
> > them on our mailing list, but hitting them is much less likely than a
> > drive failure for ReiserFS users on the whole.  2.4.17 looks like our
> > most stable version yet.  Marcello does a really nice job of quickly
> > integrating patches.
>
> Merry Christmas !
>
> Is the NFS conjunction for reiserfs for Servers now usable stable ?
> Means, no panic patches nessesary not patch-of-the-day anymore, just
> linux-like-rocks-steady-working ?
>
> (In the past ther were to much headaches and patches ...)
> Just asking before upgrading any server.
>
> Have nice X-Mas...
> 	J. Sauer
>
> --
> Jürgen Sauer - AutomatiX GmbH, +49-4209-4699, jojo@automatix.de **
> ** Das Linux Systemhaus - Service - Support - Server - Lösungen **
> http://www.automatix.de to Mail me: remove: -not-for-spawm-     **
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


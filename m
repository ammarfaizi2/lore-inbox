Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265581AbSJSKTd>; Sat, 19 Oct 2002 06:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265584AbSJSKTd>; Sat, 19 Oct 2002 06:19:33 -0400
Received: from cibs9.sns.it ([192.167.206.29]:15369 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S265581AbSJSKTc>;
	Sat, 19 Oct 2002 06:19:32 -0400
Date: Sat, 19 Oct 2002 12:25:31 +0200 (CEST)
From: venom@sns.it
To: GrandMasterLee <masterlee@digitalroadkill.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: QLogic 2300 and XFS
In-Reply-To: <1034958827.25648.0.camel@localhost>
Message-ID: <Pine.LNX.4.43.0210191220120.27605-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I use QLA2200F and QLA2300F also with 500 or more GBs, but I have a lot
of lun of 32 GB provided by MC^2, and reiserFS. At the momenti my are
mainly tests before deciding an effective use in production environment.

I use kernel 2.4.19 with the reiver prided by qlogic version 6.01.

I used both with LVM1 (concatenate) and without, gone till 45 days of
uptime, then had to reboot because of kernel upgrade, but the server was
really used and stressed for just about 5 days.


Luigi

On 18 Oct 2002, GrandMasterLee wrote:

> Date: 18 Oct 2002 11:33:48 -0500
> From: GrandMasterLee <masterlee@digitalroadkill.net>
> To: linux-kernel@vger.kernel.org
> Subject: QLogic 2300 and XFS
>
> Does anyone on this list use XFS plus QLA2300's with 500GB+ mounted as
> several volumes on Qlogic driver 5.38.x or > and have greater than 20
> days uptime to date?
>
> TIA
>
> --The GrandMaster
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


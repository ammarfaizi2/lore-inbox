Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136974AbRAHMGN>; Mon, 8 Jan 2001 07:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137084AbRAHMGE>; Mon, 8 Jan 2001 07:06:04 -0500
Received: from Prins.externet.hu ([212.40.96.161]:1286 "EHLO prins.externet.hu")
	by vger.kernel.org with ESMTP id <S136974AbRAHMGB>;
	Mon, 8 Jan 2001 07:06:01 -0500
Date: Mon, 8 Jan 2001 13:05:33 +0100 (CET)
From: Narancs 1 <narancs1@externet.hu>
To: Nils Philippsen <nils@fht-esslingen.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: postgres/shm problem
In-Reply-To: <Pine.LNX.4.30.0101081243530.8952-100000@rhlx01.fht-esslingen.de>
Message-ID: <Pine.LNX.4.02.10101081304400.17427-100000@prins.externet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, Nils Philippsen wrote:

> 
> #define SHMALL (SHMMAX/PAGE_SIZE*(SHMMNI/16)) /* max shm system wide (pages)
> */
> On my machine here, it is 2097152. It should be the same on any Intel IA32
ok thanks for it! I donwanna reboot my computer ;-)

10x4all
Narancs v1

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

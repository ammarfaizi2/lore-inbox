Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130656AbRAHLYr>; Mon, 8 Jan 2001 06:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131097AbRAHLYh>; Mon, 8 Jan 2001 06:24:37 -0500
Received: from Prins.externet.hu ([212.40.96.161]:42770 "EHLO
	prins.externet.hu") by vger.kernel.org with ESMTP
	id <S130656AbRAHLYX>; Mon, 8 Jan 2001 06:24:23 -0500
Date: Mon, 8 Jan 2001 12:23:15 +0100 (CET)
From: Narancs 1 <narancs1@externet.hu>
To: Nils Philippsen <nils@fht-esslingen.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: postgres/shm problem
In-Reply-To: <Pine.LNX.4.30.0101081142090.8952-100000@rhlx01.fht-esslingen.de>
Message-ID: <Pine.LNX.4.02.10101081222211.17427-100000@prins.externet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, Nils Philippsen wrote:


> /proc/sys/kernel/shmall to "0" (that is the maximum number of SHM segments).
yes, powertweak made it wrong.
what is the good value for it?

thx
Narancs v1

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136963AbRAHL5x>; Mon, 8 Jan 2001 06:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137140AbRAHL5n>; Mon, 8 Jan 2001 06:57:43 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:31251 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136963AbRAHL5b>; Mon, 8 Jan 2001 06:57:31 -0500
Subject: Re: postgres/shm problem
To: narancs1@externet.hu (Narancs 1)
Date: Mon, 8 Jan 2001 11:58:51 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.02.10101081110001.1837-100000@prins.externet.hu> from "Narancs 1" at Jan 08, 2001 11:10:45 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Faww-0004Oa-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there any other solution than recompiling programs?
> all of the program which need shm/ipc will turn blue?

Congratulations you are running an old version of powertweak. Remvoe that
and it should recover (its setting shm limits to 0)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

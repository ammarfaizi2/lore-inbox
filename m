Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129597AbQKFSlT>; Mon, 6 Nov 2000 13:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129653AbQKFSlJ>; Mon, 6 Nov 2000 13:41:09 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:3845 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129597AbQKFSlA>;
	Mon, 6 Nov 2000 13:41:00 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200011061840.VAA20563@ms2.inr.ac.ru>
Subject: Re: [patch] NE2000
To: comandante@zaralinux.COM (Jorge Nerin)
Date: Mon, 6 Nov 2000 21:40:37 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A069762.CBF6272B@zaralinux.com> from "Jorge Nerin" at Nov 6, 0 08:45:04 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>         if ((current->state & (TASK_INTERRUPTIBLE|TASK_UNINTERRUPTIBLE))
> == 0)
>                 BUG();

The Puzzle... 8) It is truly impossible.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130448AbRCLUJY>; Mon, 12 Mar 2001 15:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130451AbRCLUJE>; Mon, 12 Mar 2001 15:09:04 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:18707 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S130448AbRCLUI6>;
	Mon, 12 Mar 2001 15:08:58 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200103122008.XAA11117@ms2.inr.ac.ru>
Subject: Re: Feedback for fastselect and one-copy-pipe
To: manfred@colorfullife.com (Manfred Spraul)
Date: Mon, 12 Mar 2001 23:08:23 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000f01c0ab2f$d81a78c0$5517fea9@local> from "Manfred Spraul" at Mar 12, 1 09:05:37 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> freebsd

Very funny, the idea is borrowed from there.

As you could understand your patch kills it. PAGE_SIZE is one of the most
frequently used transfer unit.

Alexey

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130600AbRCLUce>; Mon, 12 Mar 2001 15:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130606AbRCLUcZ>; Mon, 12 Mar 2001 15:32:25 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:27667 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S130600AbRCLUcN>;
	Mon, 12 Mar 2001 15:32:13 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200103122031.XAA11304@ms2.inr.ac.ru>
Subject: Re: Feedback for fastselect and one-copy-pipe
To: manfred@colorfullife.com (Manfred Spraul)
Date: Mon, 12 Mar 2001 23:31:38 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <001b01c0ab33$07ff5670$5517fea9@local> from "Manfred Spraul" at Mar 12, 1 09:28:38 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> freebsd-4.0 doesn't use direct transfers for PAGE_SIZE'd pipe write()s:
> it uses  MINDIRECT=8192.

I see.

> (and PIPE_BUF is 512, so 4096 was possible for
> them)

8) I see.

Thank you for patience. 8)

Alexey

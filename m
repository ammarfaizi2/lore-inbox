Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129742AbRAXUpF>; Wed, 24 Jan 2001 15:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130648AbRAXUo4>; Wed, 24 Jan 2001 15:44:56 -0500
Received: from [205.205.44.10] ([205.205.44.10]:50955 "EHLO
	sembo111.teknor.com") by vger.kernel.org with ESMTP
	id <S129742AbRAXUor>; Wed, 24 Jan 2001 15:44:47 -0500
Message-ID: <5009AD9521A8D41198EE00805F85F18F683FCC@SEMBO111>
From: "Isabelle, Francois" <Isabellf@Teknor.com>
To: "Linux-Kernel@Vger. Kernel. Org. (E-mail)" 
	<linux-kernel@vger.kernel.org>
Cc: "'Per Hedeland' (E-mail)" <Per@bluetail.com>
Subject: Silly Question
Date: Wed, 24 Jan 2001 15:44:30 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is something I try to do using Linux and I think you may have a clue:

I want to use the external loopback of my ethernet interface to test it. I
want the data to actually go through the cable and I don't want internal
logic to bypass this process.
There is only one interface available, so I can't use swapped routing as
explained here:
http://www.tux.org/hypermail/linux-kernel/1999week21/0294.html.
I'm not sure if this is kernel specific or if some commands may override
default routing behavior.
Any ideas?

Francois Isabelle

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131051AbRAIUOX>; Tue, 9 Jan 2001 15:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131044AbRAIUON>; Tue, 9 Jan 2001 15:14:13 -0500
Received: from falcon.etf.bg.ac.yu ([147.91.8.233]:517 "EHLO
	falcon.etf.bg.ac.yu") by vger.kernel.org with ESMTP
	id <S131911AbRAIUOD>; Tue, 9 Jan 2001 15:14:03 -0500
Date: Tue, 9 Jan 2001 21:13:46 +0100 (CET)
From: Bosko Radivojevic <bole@falcon.etf.bg.ac.yu>
To: linux-kernel@vger.kernel.org
Subject: suser checks in 2.2.x
In-Reply-To: <5.0.0.25.0.20010109145610.03b02090@mail.etinc.com>
Message-ID: <Pine.LNX.4.20.0101092100320.15661-100000@falcon.etf.bg.ac.yu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello to all

I can see there are a lot of suser() checks. When they will be changed
with appropriate capable(..) checks? Or, will they be changed, at all some
days?

What is going on with VFS capabilities support?

Greetings


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

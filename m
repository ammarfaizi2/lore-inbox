Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130797AbRAHD6G>; Sun, 7 Jan 2001 22:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136730AbRAHD54>; Sun, 7 Jan 2001 22:57:56 -0500
Received: from adsl-63-204-197-52.dsl.snfc21.pacbell.net ([63.204.197.52]:2565
	"EHLO mail.topdollargeek.com") by vger.kernel.org with ESMTP
	id <S130797AbRAHD5n>; Sun, 7 Jan 2001 22:57:43 -0500
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.0 APM w/ Compaq 16xx laptop...
Message-ID: <978926262.3a593ab671347@www.sunshinecomputing.com>
Date: Sun, 07 Jan 2001 19:57:42 -0800 (PST)
From: Brian Macy <bmacy@macykids.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 63.204.197.51
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone get this working? If so please tell me the version of you APM utilities
and what Power Management options you have on in the kernel.

Ever since I started trying 2.3.x, as soon as the box gets a change in it's
power status (even just an update of the % battery) Linux locks solid. It's 100%
repeatable.

In particular this is a Compaq Presario 1670. If I remove APM from the kernel it
runs perfectly... but no APM on a laptop really sucks.

Brian Macy
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

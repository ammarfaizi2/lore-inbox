Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129268AbRCBPry>; Fri, 2 Mar 2001 10:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129270AbRCBPrp>; Fri, 2 Mar 2001 10:47:45 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:56332 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129268AbRCBPrg>;
	Fri, 2 Mar 2001 10:47:36 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200103021547.SAA16651@ms2.inr.ac.ru>
Subject: Re: Another rsync over ssh hang (repeatable, with 2.4.1 on both ends)
To: rmk@arm.linux.ORG.UK (Russell King)
Date: Fri, 2 Mar 2001 18:47:18 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010302101236.A21799@flint.arm.linux.org.uk> from "Russell King" at Mar 2, 1 01:45:01 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I've also reported

The report by Scott Laird is sane unlike your one.
It can be explained by bug rather than only by poltergeist. 8)


> Thanks for confirming that 2.2.15pre13 is not the cause.

Russel, you are warned that kernels<2.2.17 and rsync is an incompatible
combination.

Alexey

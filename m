Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131724AbRCORX1>; Thu, 15 Mar 2001 12:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131726AbRCORXR>; Thu, 15 Mar 2001 12:23:17 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:54020 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S131724AbRCORXD>;
	Thu, 15 Mar 2001 12:23:03 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200103151722.UAA28854@ms2.inr.ac.ru>
Subject: Re: poll() behaves differently in Linux 2.4.1 vs. Linux 2.2.14 (POLLHUP)
To: jeffreymbutler@yahoo.com (Jeffrey Butler)
Date: Thu, 15 Mar 2001 20:22:01 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org, davem@redhat.COM
In-Reply-To: <20010315040013.28464.qmail@web11804.mail.yahoo.com> from "Jeffrey Butler" at Mar 14, 1 08:00:13 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Sure, workarounds exist, but they just complicates
> things.

Working around --- what?

An example of application hitting the case is enough to make
me completely agreed.

But genarally we are not going to match any os and even yourselves
yesterday or tomorrow in the cases when behaviour is truly undefined
and the answer is meaningless. For me any solution from retunring 0
or returning POLLHUO to killing offending application or generating
an answer using random number generator look equally good, acceptable
and 100% compatible in this case. 8)

Alexey

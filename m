Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268342AbRGZRDu>; Thu, 26 Jul 2001 13:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268357AbRGZRDl>; Thu, 26 Jul 2001 13:03:41 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:43282 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S268342AbRGZRDd>;
	Thu, 26 Jul 2001 13:03:33 -0400
Message-Id: <200107260654.KAA00363@mops.inr.ac.ru>
Subject: Re: Arp problem
To: kubla@sciobyte.DE (Dominik Kubla)
Date: Thu, 26 Jul 2001 10:54:19 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010725124048.A9264@intern.kubla.de> from "Dominik Kubla" at Jul 25, 1 03:15:00 pm
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

> But that turns off all ip redirect sending, which may pose different
> problems.  Kind of sledgehammer approach wouldn't you agree?  If somebody
> were to produce a patch that allowed full routing between aliased interfaces
> without turning off ip redirect sending, would you accept this?

It is difficult to guess what do you mean exactly, but I could advise
you to look through ip-sysctl.txt about options controlling redirects.
If some case is missed here, shame on me...

Alexey

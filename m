Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266665AbTAIN1Z>; Thu, 9 Jan 2003 08:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266675AbTAIN1Z>; Thu, 9 Jan 2003 08:27:25 -0500
Received: from [213.171.53.133] ([213.171.53.133]:9234 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id <S266665AbTAIN1Y>;
	Thu, 9 Jan 2003 08:27:24 -0500
Date: Thu, 9 Jan 2003 16:38:05 +0300
From: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
X-Mailer: The Bat! (v1.61)
Reply-To: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
Organization: CITL MIEE
X-Priority: 3 (Normal)
Message-ID: <156515012498.20030109163805@wr.miee.ru>
To: Dave Jones <davej@codemonkey.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: observations on 2.5 config screens
In-Reply-To: <20030108195000.GA670@codemonkey.org.uk>
References: <1042041195.694.2734.camel@phantasy>
 <Pine.LNX.3.96.1030108132758.22872B-100000@gatekeeper.tmr.com>
 <20030108195000.GA670@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DJ>  > Processor option would select the processor and any architecture dependent
DJ>  > options, I would think. Something like "kernel characteristics" could have
DJ>  > options like smp.
DJ> SMP isn't a processor option ?
DJ>                 Dave
Good day!
I think, first of all it's "General Kernel options(features)" to
support SMP(Preempt, MTRR) or not.
And may be would be better to move Processor Family and SubArch menu
to the top level of the menu? Then merge "General setup" and "Processor
type and features" in one menu.
It's just my opinion, no more.

 Ruslan                          mailto:cubic@wr.miee.ru


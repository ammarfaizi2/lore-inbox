Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263284AbUDMEFO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 00:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbUDMEFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 00:05:13 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:5589 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263284AbUDMEFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 00:05:07 -0400
To: dl8bcu@dl8bcu.de
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, rth@twiddle.net,
       spyro@f2s.com, rmk@arm.linux.org.uk, paulus@au.ibm.com,
       benh@kernel.crashing.org, jes@trained-monkey.org, ralf@gnu.org,
       matthew@wil.cx, davem@redhat.com, wesolows@foobazco.org,
       jdike@karaya.com, ak@suse.de
Subject: Re: [PATCH][RFC] sort out CLOCK_TICK_RATE usage [1/3]
References: <20040412075519.A5198@Marvin.DL8BCU.ampr.org>
	<20040412075704.B5198@Marvin.DL8BCU.ampr.org>
	<16506.50767.128817.828166@napali.hpl.hp.com>
	<20040412200835.A5625@Marvin.DL8BCU.ampr.org>
	<16506.64729.917048.491827@napali.hpl.hp.com>
	<20040412211754.A5770@Marvin.DL8BCU.ampr.org>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 13 Apr 2004 13:04:31 +0900
In-Reply-To: <20040412211754.A5770@Marvin.DL8BCU.ampr.org>
Message-ID: <buofzb8o75c.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Kranzkowski <dl8bcu@dl8bcu.de> writes:
> Since INPUT_PCSPKR seems to be available on all archs, every arch must
> have some idea of PI[CT]_TICK_RATE, no?

What are you talking about?  I see no INPUT_PCSPKR defined on my arch
anywhere, and don't even know what an 8253 is... [so it would be damn
silly to have <asm/8253pit.h> as a required header!]

Don't assume everything is like a PC.

-Miles
-- 
"1971 pickup truck; will trade for guns"

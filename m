Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292700AbSCJBPe>; Sat, 9 Mar 2002 20:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292702AbSCJBPZ>; Sat, 9 Mar 2002 20:15:25 -0500
Received: from hermes.toad.net ([162.33.130.251]:18602 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S292700AbSCJBPT>;
	Sat, 9 Mar 2002 20:15:19 -0500
Subject: Re: apm problems on thinkpad
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 09 Mar 2002 20:16:22 -0500
Message-Id: <1015722984.988.261.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I never use suspend with Linux because I haven't take
> the time to investigate whether I need a separate suspend
> partition

I think we have terminological problems here.  I know that the
various kinds of sedation are termed differently by different
manufacturers, but usually:

'standby' refers to a state of mildly reduced power consumption
which can be ended immediately;

'suspend' refers to a state of severely reduced power
consumption in which peripherals are switched off but the
CPU and RAM are kept powered up;

'hibernation' refers to a state of zero power consumption
in which the entire system state is saved to disk and the
machine is powered off.

On a ThinkPad, standby seems to consist of the screen 
being switched off.  Suspend and hibernation are as 
described above.


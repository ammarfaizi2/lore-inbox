Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263629AbUEVClJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263629AbUEVClJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 22:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263134AbUEVClJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 22:41:09 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:27635 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S264878AbUEVCgy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 22:36:54 -0400
Date: Fri, 21 May 2004 23:03:42 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Geoff Mishkin <gmishkin@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: live power to usb cable
Message-ID: <20040521230342.A5342@mail.kroptech.com>
References: <1085082330.8372.43.camel@amsa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1085082330.8372.43.camel@amsa>; from gmishkin@comcast.net on Thu, May 20, 2004 at 03:45:30PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2004 at 03:45:30PM -0400, Geoff Mishkin wrote:
> On my USB cables that have connectors on both ends, one end is live when
> the other end is plugged into the computer.  I can get a pretty decent
> shock from the other end of the cable.  This seems kind of dangerous. 
> Am I barking up the wrong tree here or is this an issue that should be
> fixed?

There isn't enough voltage present on a normal USB cable to be felt or
even remotely harmful. If you're getting shocked by your cable it's
probably due to an electrical mains wiring fault. Make certain your
computer power supply is properly grounded (i.e. your power cable,
outlet strip, and wall outlet are all grounded). If you have a voltmeter,
test for AC voltage between the shell of the USB cable (or an unpainted
spot on the computer's case) and another ground. Chances are good your
electrical wiring is messed up. You can pick up a universal little
tester with 3 lights on it at Wal-Mart for $10 or so. It'll tell you if
any of the circuit legs are miswired.

I lived in an apartment once where there was nearly 65 volts AC between
the grounds of two different circuits. I first noticed it when I 
grabbed the end of a serial cable in one hand and went to plug it into
the back of a computer on another circuit. Woke me right up.

--Adam


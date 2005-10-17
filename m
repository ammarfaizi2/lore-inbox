Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbVJQWlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbVJQWlt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 18:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVJQWlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 18:41:25 -0400
Received: from science.horizon.com ([192.35.100.1]:22320 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932360AbVJQWlO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 18:41:14 -0400
Date: 17 Oct 2005 18:41:13 -0400
Message-ID: <20051017224113.23667.qmail@science.horizon.com>
From: linux@horizon.com
To: linux@horizon.com, zippel@linux-m68k.org
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0510172050460.1386@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I have to disagree.  Once you grasp the desirability of having two kinds
>> of timers, one optimized for the case where it does expire, and one
>> optimized for the case where it is aborted or rescheduled before its
>> expiration time, the timer/timeout terminology seems quite intuitive
>> to me.

> Thank you, that's exactly the confusion, I'd like to avoid.

Er... *what* confusion?  I wasn't in the slightest bit confused when
I wrote that, and re-reading it very carefully, I can't see how
it could be interpreted in a way that is in any way confusing.

There's no more confusion in that paragraph than there is lemon meringue.

The only thing confusing is your response.

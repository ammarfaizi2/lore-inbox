Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263123AbTIVMXe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 08:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbTIVMXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 08:23:34 -0400
Received: from smtp1.att.ne.jp ([165.76.15.137]:22932 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S263123AbTIVMXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 08:23:33 -0400
Message-ID: <0c2201c38104$36fc9100$44ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Vojtech Pavlik" <vojtech@suse.cz>, "Andries Brouwer" <aebr@win.tue.nl>
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, <linux-kernel@vger.kernel.org>
References: <1b7301c37a73$861bea70$2dee4ca5@DIAMONDLX60> <20030914122034.C3371@pclin040.win.tue.nl> <206701c37ab2$6a8033e0$2dee4ca5@DIAMONDLX60> <20030916154305.A1583@pclin040.win.tue.nl> <20030921110629.GC18677@ucw.cz> <20030921143934.A11315@pclin040.win.tue.nl> <20030921124817.GA19820@ucw.cz> <20030921164914.C11315@pclin040.win.tue.nl> <20030921170710.GA20856@ucw.cz>
Subject: Re: 2.6.0-test5 vs. Japanese keyboards [3]
Date: Mon, 22 Sep 2003 21:22:00 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

> Also, this causes trouble with the japanese keys in XFree86, since the
> KEY_INTL* keys are in the e0 xx range because of the emulation.

But the Japanese keys under discussion are not e0 keys.  When the mail
reaches you, please try them with showkeys -s under kernel 2.4.  XFree86
might not be the only program that depends on getting the correct scan
codes.


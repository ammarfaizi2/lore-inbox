Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263156AbTDFXFF (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 19:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbTDFXFF (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 19:05:05 -0400
Received: from smtp1.poczta.onet.pl ([213.180.130.31]:8100 "EHLO
	smtp1.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S263156AbTDFXFE (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 19:05:04 -0400
To: linux-kernel@vger.kernel.org
From: filip <filip_@op.pl>
Date: Mon, 07 Apr 2003 1:16:26 +0200
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Subject: paralel port - doesn't keep pins states
Mime-Version: 1.0
X-Mailer: onet.poczta
Message-Id: <E192JNC-0004Dy-00@f28.test.onet.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I hope it is the right place to ask about my problem...

I want to use /dev/lp0 (lp module) on my PC for controlling
external devices.
The problem is when I wtire 1 byte to /dev/lp0, paralel port
keeps this state just for few ms...
(I made special plug - so the is no problem with handshake - details on:
http://www.hut.fi/Misc/Electronics/circuits/nullprint.html)

It is strange because everything works corect on my old PC (Pentium160).

Regards,
Filip

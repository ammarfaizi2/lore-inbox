Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbTKJXXr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 18:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263259AbTKJXXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 18:23:46 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:32260 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263258AbTKJXXq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 18:23:46 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: 2.4 and cryptoloop
Date: 10 Nov 2003 23:13:12 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bop628$7km$1@gatekeeper.tmr.com>
X-Trace: gatekeeper.tmr.com 1068505992 7830 192.168.12.62 (10 Nov 2003 23:13:12 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see that recent 2.4 has crypto. Is there a version of the tools which
will do cryptoloop using the kernel as released? I tried the old 2.4
version I had, and the latest version which works with 2.6, neither
worked to do an losetup.

Yes, I know about the add-in support, I'm just wondering if the recent
kernel. say 2.4.22-ac4, has the capability if I ask it nicely. I'd like
to share data already in use with aes under 2.6.0-testX.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

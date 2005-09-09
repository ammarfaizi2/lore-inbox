Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030450AbVIIUQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030450AbVIIUQb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 16:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030451AbVIIUQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 16:16:30 -0400
Received: from guru.webcon.ca ([216.194.67.26]:38553 "EHLO guru.webcon.ca")
	by vger.kernel.org with ESMTP id S1030450AbVIIUQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 16:16:29 -0400
Date: Fri, 9 Sep 2005 16:16:07 -0400 (EDT)
From: "Ian E. Morgan" <imorgan@webcon.ca>
X-X-Sender: imorgan@light.int.webcon.net
To: Andrew Morton <akpm@osdl.org>, Wim Van Sebroeck <wim@iguana.be>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Webcon Technical Support <tech@webcon.ca>
Subject: [WATCHDOG] Push SBC8360 driver upstream
Message-ID: <Pine.LNX.4.63.0509091556520.16138@light.int.webcon.net>
Organization: "Webcon, Inc"
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Assp-Spam-Prob: 0.00000
X-Assp-Envelope-From: imorgan@webcon.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to ask that the SBC8360 watchdog driver be pushed upstream from
-mm in time for the 2.6.14-rc series.

I recognise that this driver, like a lot of the watchdog drivers, is for a
piece of hardware this is present in only a very small percentage of
hardware runnig Linux. I doubt that being in -mm for a long time will make
any significant difference to it being more widely tested. The driver is
working perfectly as expected on each of the machines we've tested it on.

As a recap, the driver was submitted to akpm, was included in -mm1
(watchdog-new-sbc8360-driver.patch), offloaded to Wim's
linux-2.6-watchdog-mm.git tree (commit
88b1f50923d14195ac1a50840fc4aa4066f067a9), and subsequently included in -mm2
by way of the combined git-watchdog.patch.

Please consider merging this driver into 2.6.14-rc1. Thanks.

Regards,
Ian Morgan

-- 
-------------------------------------------------------------------
 Ian E. Morgan          Vice President & C.O.O.       Webcon, Inc.
 imorgan at webcon dot ca       PGP: #2DA40D07       www.webcon.ca
    *  Customized Linux Network Solutions for your Business  *
-------------------------------------------------------------------

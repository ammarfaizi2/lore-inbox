Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264137AbTEWS6A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 14:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264138AbTEWS6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 14:58:00 -0400
Received: from imo-r01.mx.aol.com ([152.163.225.97]:41464 "EHLO
	imo-r01.mx.aol.com") by vger.kernel.org with ESMTP id S264137AbTEWS57
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 14:57:59 -0400
Date: Fri, 23 May 2003 15:11:03 -0400
From: jpo234@netscape.net
To: linux-kernel@vger.kernel.org
Subject: Dead machine, blinking Keyboard and no Oops on console
MIME-Version: 1.0
Message-ID: <27E0EA8B.2CDE9C50.00065BAA@netscape.net>
X-Mailer: Atlas Mailer 2.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List,
the Subject basically describes what I see. This is (yeah, I know)
a SuSE kernel with a small local hack. I don't expect that anybody
will debug this for me, but maybe some clues what could cause this
would be most welcome.

Specifics (just in case this rings a bell):
Kernel is a local build from the SuSE kernel-source-2.4.19.SuSE-175.i586.rpm RPM (e.g. the current one),
my local patch adds socket specific statistics (e.g. packet count,
retransmits, out-of-order packets,...).

Observation:
No Oops, no panic, just a sudden freeze with the blinking keyboard
lights.

Thanks in advance
  Jörg

__________________________________________________________________
McAfee VirusScan Online from the Netscape Network.
Comprehensive protection for your entire computer. Get your free trial today!
http://channels.netscape.com/ns/computing/mcafee/index.jsp?promo=393397

Get AOL Instant Messenger 5.1 free of charge.  Download Now!
http://aim.aol.com/aimnew/Aim/register.adp?promo=380455

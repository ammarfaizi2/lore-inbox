Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263700AbTKAChA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 21:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263703AbTKAChA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 21:37:00 -0500
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:13976 "EHLO
	harrier.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S263700AbTKACg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 21:36:58 -0500
Subject: oops with pci=biosirq in 2.4.22 (not in 2.4.18)
From: Brad Langhorst <brad@langhorst.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1067654215.19557.412.camel@up>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 31 Oct 2003 21:36:56 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately I can't get a copy of the oops because 
the screen immediately fills with hex addresses 
(looks like a looping call trace)

2.6.0test9 does not suffer from this problem.

I don't have time to try more kernels and narrow the window at the
moment.

perhaps this is enough information for somebody who knows where to look.

brad




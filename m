Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbVKSEoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbVKSEoM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 23:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbVKSEoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 23:44:12 -0500
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:57758 "HELO
	smtp106.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750909AbVKSEoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 23:44:12 -0500
Message-Id: <20051119043840.747384000.dtor_core@ameritech.net>
Date: Fri, 18 Nov 2005 23:38:40 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Mark Vojkovich <mvojkovi@XFree86.Org>,
       Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
       Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>,
       Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org
Subject: [patch 0/3] Uinput update
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patches update uinput driver to perform dynamic input
allocation, add some locking and ioctl to allow setting EV_SW.

Any testing will be greatly appreciated.

Thanks!

--
Dmitry


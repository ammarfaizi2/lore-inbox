Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264932AbTFCFVU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 01:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264934AbTFCFVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 01:21:20 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:20723 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S264932AbTFCFVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 01:21:19 -0400
Subject: Re: [RFC PATCH] Re: [OOPS] w83781d during rmmod (2.5.69-bk17)
From: Martin Schlemmer <azarah@gentoo.org>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Sensors <sensors@stimpy.netroedge.com>
In-Reply-To: <20030602172040.GC4992@kroah.com>
References: <20030524183748.GA3097@earth.solarsys.private>
	 <3ED8067E.1050503@paradyne.com>
	 <20030601143808.GA30177@earth.solarsys.private>
	 <20030602172040.GC4992@kroah.com>
Content-Type: text/plain
Organization: 
Message-Id: <1054617753.5269.44.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 03 Jun 2003 07:22:34 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-02 at 19:20, Greg KH wrote:

Hiya Greg

While sorda on the topic ... since I did the w83781d driver some time
ago, I changed boards for a P4C800 (Intel 875 chipset), that have a
ICH5 southbridge, and not a ICH4 one ....  I tried to add the ID's
to the i810 driver, and although it does load (even without the
ID's added), the I2C bus/sensor does not show in /sys.  The w83781d
driver also load fine btw.

Any ideas ? Anybody working on 875 support that I can help test ?


Thanks,

-- 
Martin Schlemmer



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964937AbVLJGsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbVLJGsk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 01:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbVLJGsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 01:48:40 -0500
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:890 "HELO
	smtp106.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964937AbVLJGsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 01:48:40 -0500
Message-Id: <20051210063626.817047000.dtor_core@ameritech.net>
Date: Sat, 10 Dec 2005 01:36:26 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Jean Delvare <khali@linux-fr.org>
Subject: [patch 0/2] Add platform_device_del()
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

OK, so here is the patch adding platform_device_del() that we were
discussing. The second patch just moves exports around so we do not
mix two styles in one source file.

Greg, if you are OK with it - are you going to push it or maybe I
should put it in my tree so I can publish pieces depending on this
as they are getting ready?

--
Dmitry


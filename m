Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbVIMFaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbVIMFaL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 01:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbVIMFaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 01:30:11 -0400
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:55979 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932294AbVIMFaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 01:30:10 -0400
Message-Id: <20050913052026.358863000.dtor_core@ameritech.net>
Date: Tue, 13 Sep 2005 00:20:26 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: irda-users@lists.sourceforge.net
Cc: Jean Tourrilhes <jt@hpl.hp.com>, linux-kernel@vger.kernel.org
Subject: [patch 0/2] IRDA: convert nsc-ircc to the new PM scheme
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is an attempt to move nsc-ircc driver from pm_register
to the new power management scheme by creating a platform
driver and registering it with sysfs.

I do not have the hardware so it is compiles but that's as
far as I can go. If you happen to have the hardware in question
I'd appreciate giving these patches a spin.

Thank you.

--
Dmitry


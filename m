Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbTKRLCX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 06:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbTKRLCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 06:02:22 -0500
Received: from mail.tactel.se ([195.22.66.197]:28608 "EHLO mail.tactel.se")
	by vger.kernel.org with ESMTP id S262546AbTKRLCV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 06:02:21 -0500
Subject: Announce: ndiswrapper
From: Pontus Fuchs <pof@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1069153340.2200.28.camel@dhcp-225.mlm.tactel.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 18 Nov 2003 12:02:20 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since some vendors refuses to release specs or even a binary
Linux-driver for their WLAN cards I desided to try to solve it myself by
making a kernel module that can load Ndis (windows network driver API)
drivers. I'm not trying to implement all of the Ndis API but rather
implement the functions needed to get these unsupported cards working.

Currently it works fine with my Broadcom 4301 but I would like to get in
touch with people that have similar cards that are willing to do some
testing/hacking.

Visit this page for more info: http://ndiswrapper.sourceforge.net/

Please! I don't want to start a flamewar if this is a good thing to do.
I'm just trying to scratch my own itch and I doubt that this project
changes the way Broadcom treats Linux users.

Pontus Fuchs



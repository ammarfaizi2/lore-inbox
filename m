Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265673AbUBPQW7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 11:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265700AbUBPQW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 11:22:59 -0500
Received: from sitemail3.everyone.net ([216.200.145.37]:48097 "EHLO
	omta06.mta.everyone.net") by vger.kernel.org with ESMTP
	id S265673AbUBPQW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 11:22:58 -0500
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
Date: Mon, 16 Feb 2004 08:22:56 -0800 (PST)
From: john moser <bluefoxicy@linux.net>
To: linux-kernel@vger.kernel.org
Subject: Radeon IGP drivers
Reply-To: bluefoxicy@linux.net
X-Originating-Ip: [68.33.187.247]
Message-Id: <20040216162256.0272F395B@sitemail.everyone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC replies to me.

Some patches are referenced at the following link for the xfree86 CVS:
http://www.google.com/search?q=cache:GSp4PKNHFpAJ:www.cliff.biffle.org/cpq2100.php+linux+presario+2100+3D&hl=en&ie=UTF-8

These patches do two things.  One allows X to use IGP drivers with DRI.  The
other generates a .ko for Linux 2.6 that works with the Radeon IGP cards.

It is the responsibility of the XFree86 project to merge in the DRI patch;
however, the new IGP-compatible Radeon driver
( http://www.cliff.biffle.org/patches/radeon_igp-2.6.patch )
is a kernel driver.  Has this been moved into the Linux source tree yet?  If
not, could someone move it into the tree?  Better to have it now than to wait
for X 4.4 to come out and (possibly) have the DRI patch merged in before
scrambling to get a working driver.

_____________________________________________________________
Linux.Net -->Open Source to everyone
Powered by Linare Corporation
http://www.linare.com/

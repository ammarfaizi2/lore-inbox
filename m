Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262569AbTCMW2y>; Thu, 13 Mar 2003 17:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262570AbTCMW2y>; Thu, 13 Mar 2003 17:28:54 -0500
Received: from air-2.osdl.org ([65.172.181.6]:37032 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262569AbTCMW2y>;
	Thu, 13 Mar 2003 17:28:54 -0500
Subject: [PATCH] (0/5) Brlock removal (2.5.64)
From: Stephen Hemminger <shemminger@osdl.org>
To: Andrew Morton <akpm@digeo.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1047595177.3139.93.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 13 Mar 2003 14:39:37 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This version incorporates review and feedback from earlier version.

 1 - net/core
 2 - vlan and snap
 3 - bridge
 4 - ipv4/ipv6
 5 - remove brlock code

See each patch for description of changes.
These patches are ready for further testing, but not for final Linus
merge.  






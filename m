Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274306AbRITEQn>; Thu, 20 Sep 2001 00:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274305AbRITEQe>; Thu, 20 Sep 2001 00:16:34 -0400
Received: from nsd.mandrakesoft.com ([216.71.84.35]:21091 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S274143AbRITEQ1>; Thu, 20 Sep 2001 00:16:27 -0400
Date: Wed, 19 Sep 2001 23:16:49 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: linux-net@vger.kernel.org, netdev@oss.sgi.com
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: ethtool 1.3 released
Message-ID: <Pine.LNX.3.96.1010919230927.16972D-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(this is directed to linux-kernel just this once; future announcements
will be limited to the linux-net and netdev mailing lists.)

A new version of ethtool was just posted on its homepage, at

	http://sf.net/projects/gkernel/

This version adds Wake-on-LAN support courtesy of Tim Hockin.

You need kernel 2.4.9 or later, hardware which supports Wake-on-LAN, and
a driver which supports Wake-on-LAN to take advantage of this.

Since it takes a little while for SourceForge's database to post the new
file locations, you can optionally use this direct (and permanent) link:
http://prdownloads.sourceforge.net/gkernel/ethtool-1.3.tar.gz


What is ethtool?

ethtool is a general diagnostic utility for your network adapter.  It
allows for general media selection, interrupt-based coalescing and
mitigation control, NIC diagnostics, and Wake-on-LAN manipulation.


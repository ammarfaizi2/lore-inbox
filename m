Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263776AbUESBeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263776AbUESBeM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 21:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbUESBeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 21:34:12 -0400
Received: from sitemail3.everyone.net ([216.200.145.37]:41403 "EHLO
	omta12.mta.everyone.net") by vger.kernel.org with ESMTP
	id S263776AbUESBeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 21:34:09 -0400
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
Date: Tue, 18 May 2004 18:34:08 -0700 (PDT)
From: john moser <bluefoxicy@linux.net>
To: linux-kernel@vger.kernel.org
Subject: ADM8211 chipset (DWL-650)
Reply-To: bluefoxicy@linux.net
X-Originating-Ip: [68.33.185.81]
X-Eon-Sig: AQHDJlhAqrmQAAUmyAEAAAAB,a75e854636db20cc20909694c0b2d146
Message-Id: <20040519013408.5EF82282CA4@sitemail.everyone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CC me all replies please.


OK, I can't find this in the make menuconfig (peeking under wireless
in networking).

http://www.seattlewireless.net/index.cgi/DlinkCardComments

Particularly,

1 ADM 8211 drivers
Great news on Linux, Michael Wu and Jouni Malinen are working on a
full open source linux driver. http://aluminum.sourmilk.net/adm8211/
By the time of writing this it works only on kernel 2.6 (but may be
patched for 2.4), and doesn't work with rev20 of the cards. Monitor
mode works. Help will be appreciated.


If you don't have this merged in the main tree, take a look, and if
it looks OK contact the authors or whatever you do to get it into
the main tree.  I've been wrestling with a newer DWL-650 for months
now, and would like to see it work :)

If it's already there, can you tell me where?  :/

_____________________________________________________________
Linux.Net -->Open Source to everyone
Powered by Linare Corporation
http://www.linare.com/

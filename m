Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264534AbTEKAbq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 20:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264536AbTEKAbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 20:31:46 -0400
Received: from ha90s135.d.shentel.net ([204.111.90.135]:49280 "EHLO
	charon.int.bittwiddlers.com") by vger.kernel.org with ESMTP
	id S264534AbTEKAbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 20:31:45 -0400
Date: Sat, 10 May 2003 20:44:06 -0400
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: Strange terminal problem with 2.5.6[8-9]
Message-ID: <20030511004349.GA1366@bittwiddlers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
X-Delivery-Agent: TMDA/0.75 (Ponder)
X-Primary-Address: mharrell@bittwiddlers.com
Reply-To: Matthew Harrell 
	  <mharrell-dated-1053045847.386328@bittwiddlers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The last working kernel I had under my X windows system was 2.5.67-bk7.  After
that point every 2.5.6[8-9] and bk patch has had one major problem on my
laptop - when I bring up a gnome-terminal or xterm the console prompt never
shows up.  The terminals just hang with a blinking cursor but I never get
a prompt.  If I reboot with the same setup into my 2.5.67 or any previous
kernel then everything works fine.

This is a Debian Sid system running gnome2.  Any ideas?

-- 
  Matthew Harrell                          Never underestimate the power of
  Bit Twiddlers, Inc.                       very stupid people in large groups.
  mharrell@bittwiddlers.com     

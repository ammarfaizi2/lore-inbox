Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268200AbUJDPdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268200AbUJDPdd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 11:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268212AbUJDPdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 11:33:33 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:53888 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268200AbUJDPd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 11:33:29 -0400
Message-ID: <cc61bb420410040833421e5069@mail.gmail.com>
Date: Mon, 4 Oct 2004 11:33:14 -0400
From: Robert Harris <robert.l.harris@gmail.com>
Reply-To: Robert Harris <robert.l.harris@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Driver for IBM R50 Laptop (Centrino?)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I just got an IBM R50 at work with "Centrino" according to the
little sticker.  I've got it up and running X, audio, etc.  Everything
looks good except the wireless.  I've installed the ipw2100 which
loads but doesn't find the device.  lspci gives me this:

0000:02:02.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B
Mini PCI Adapter (rev 04)

Anyone know if there's a different drive I should try?  I'm running
2.6.8.1 kernel on this puppy.

Robert
-- 

:wq!
---------------------------------------------------------------------------
Robert L. Harris

DISCLAIMER:
      These are MY OPINIONS             With Dreams To Be A King,
       ALONE.  I speak for              First One Should Be A Man
       no-one else.                       - Manowar

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263348AbTDGI7E (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 04:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263353AbTDGI7E (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 04:59:04 -0400
Received: from mta01-svc.ntlworld.com ([62.253.162.41]:62402 "EHLO
	mta01-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S263348AbTDGI7D (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 04:59:03 -0400
Subject: Via-Rhine dirve in 2.4.21-pre7
From: Mark Syms <mark@marksyms.demon.co.uk>
To: rl@hellgate.ch
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1049706637.963.6.camel@athlon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 07 Apr 2003 10:10:37 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger,

Just tried the via-rhine driver in 2.4.21-pre7 and it appears to exhibit
the problem Erik Hensema reported with the VT6103 onboard network card
on my Chaintech 7VJL Athlon board whereby you get NETDEV Watchdog
transmit timeout errors unless you turn local io-apic off in which case
it all works fine.

Please cc me directly as I'm not subscribed to the mailing list.

Thank you,

	Mark Syms


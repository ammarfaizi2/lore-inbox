Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265021AbTGBOsa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 10:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265024AbTGBOsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 10:48:30 -0400
Received: from ny.sm.luth.se ([130.240.3.1]:65251 "EHLO sm.luth.se")
	by vger.kernel.org with ESMTP id S265021AbTGBOs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 10:48:29 -0400
Date: Wed, 2 Jul 2003 17:02:53 +0200 (MEST)
From: Hakan Lennestal <hakanl@cdt.luth.se>
X-X-Sender: hakanl@delta1
To: linux-kernel@vger.kernel.org
Subject: Via-rhine problem with older hardware
Message-ID: <Pine.GSO.4.53.0307021639270.24488@delta1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi !

I'm having troubles with newer via-rhine drivers (1.1.17) and older
via-rhine hardware (VT86C100A [Rhine] (rev 06)).
With moderate CPU load (10-15 %) and some network load
(a couple of houndred kbps) I'm repeatedly getting:
  Jul  1 19:56:52 ip2 kernel: NETDEV WATCHDOG: eth0: transmit timed out
  Jul  1 19:56:52 ip2 kernel: eth0: Transmit timed out, status 0000, PHY
  status 782d, resetting...

Everything works just smoothly with via-rhine 1.1.15.

This machine does not have ACPI (or APM) enabled.

Regards.

/Håkan


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264505AbTF0RPv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 13:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbTF0RPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 13:15:51 -0400
Received: from mail03.agrinet.ch ([81.221.250.52]:59914 "EHLO
	mail03.agrinet.ch") by vger.kernel.org with ESMTP id S264505AbTF0RPs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 13:15:48 -0400
Date: Fri, 27 Jun 2003 19:29:59 +0200
From: Andreas Tscharner <starfire@dplanet.ch>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [BUG]Kernel 2.4.21: EHCI does not repeat keys
Message-Id: <20030627192959.7a903cab.starfire@dplanet.ch>
Organization: No Such Penguin
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello World,

My PS/2 keyboard is connected to my ladptop via a PS/2 to USB converter
(My laptop has no PS/2 port and there is no USB variant of my keyboard).
I have USB2.0, so I tried the EHCI. Unfortunately, the keys are not
repeated when I keep my finger on a key. This works perfectly with the
UHCI module.

Kernel 2.4.21 Debian GNU/Linux unstable

Best regards
	Andreas
-- 
Andreas Tscharner                                  starfire@dplanet.ch
----------------------------------------------------------------------
"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the Universe trying
to produce bigger and better idiots. So far, the Universe is winning."
                                                          -- Rich Cook 

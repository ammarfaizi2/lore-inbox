Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbUBNVoU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 16:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbUBNVoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 16:44:20 -0500
Received: from mail.griffel.se ([193.13.74.245]:54546 "EHLO mail.griffel.se")
	by vger.kernel.org with ESMTP id S263424AbUBNVoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 16:44:19 -0500
Date: Sat, 14 Feb 2004 22:43:48 +0100
From: Simon Gate <simon@noir.se>
To: linux-kernel@vger.kernel.org
Subject: psmouse.c: Mouse at isa0060/serio1/input0 lost synchronization,
 throwing 2 bytes away.
Message-Id: <20040214224348.67102cfd.simon@noir.se>
X-Mailer: Sylpheed version 0.9.7claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changed from kernel 2.6.1 to 2.6.2 an get this error in dmesg

psmouse.c: Mouse at isa0060/serio1/input0 lost synchronization, throwing 2 bytes away.

My mouse goes crazy for a few secs and then returns to normal for a while. Is this a 2.6.2 problem or is this is something old?

Best regards
++ Simon

*--- -  -
|  Simon Gate
|  simon@noir.se
*-  - 


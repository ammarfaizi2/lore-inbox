Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbTDFKV2 (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 06:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbTDFKV1 (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 06:21:27 -0400
Received: from halo.ispgateway.de ([62.67.200.127]:9606 "HELO
	halo.ispgateway.de") by vger.kernel.org with SMTP id S262905AbTDFKV0 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 06:21:26 -0400
Subject: USB-Mouse in 2.4.20 vs. 2.5.66 (no wheel)
From: Jens Ansorg <liste@ja-web.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1049625176.18014.7.camel@lisaserver>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 06 Apr 2003 12:32:57 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For years now I have Logitec USB wheel mice running nicely with all last
versions of the Kernel and XFree.

Current Setup is Kernel 2.4.20 and XFree 4.3

Curious as I am I build a development kernel 2.5.66

But with that kernel the scroll wheel on the mouse seems not to work
anymore in XFree/Gnome.


dmesg reports

mice: PS/2 mouse device common for all mice
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1

looks good.

but both xev and mev report no event when moving the scroll wheel on the
mouse.


should mousewheel work with the dev kernels?
 

-- 
Jens Ansorg <liste@ja-web.de>


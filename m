Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbTIYDEO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 23:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbTIYDEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 23:04:14 -0400
Received: from babyruth.hotpop.com ([204.57.55.14]:50085 "EHLO
	babyruth.hotpop.com") by vger.kernel.org with ESMTP id S261664AbTIYDEN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 23:04:13 -0400
Subject: RE: [PATCH] 2.6: joydev is too eager claiming input devices
From: Dan <overridex@punkass.com>
To: dtor_core@ameritech.net, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1064459037.19555.3.camel@nazgul.overridex.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 24 Sep 2003 23:03:57 -0400
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch seems to have broken my Logitech Wingman Action usb gamepad,
it shows as connected but isn't claimed by joydev... another joystick I
have (saitek cyborg usb gold) works fine, and the logitech worked in
previous 2.5/6.x kernels so I'm guessing this patch is to blame, I'm on
2.6.0-test5-mm1, is there any info from the joystick I can provide you
with to fix it?  I'm not sure where to look, thanks -Dan



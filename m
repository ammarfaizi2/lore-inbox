Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263619AbTDWVRo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 17:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263621AbTDWVRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 17:17:43 -0400
Received: from smtp.terra.es ([213.4.129.129]:20778 "EHLO tsmtp1.mail.isp")
	by vger.kernel.org with ESMTP id S263619AbTDWVRm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 17:17:42 -0400
Subject: Mouse on laptops
From: =?ISO-8859-1?Q?I=F1igo_Ill=E1n?= <iillan@terra.es>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1051133556.565.36.camel@Zoolander>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 23 Apr 2003 23:32:36 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Compaq Evo N115 laptop with a Synaptics touchpad (
http://compass.com/synaptics/ ). I have been using the unstable version
of the Linux kernel for some time (now I'm using version 2.5.68).

My problem comes with the external PS/2 mouse. When I plug in into the
PS/2 port the mouse wheel (or even, if I plug it before boot) doesn't
work. I think, the problem comes because PS/2 port is shared with the
synaptics touchpad, the kernel detects that the mouse type is a
Synaptics and It handles like a normal 3 button mouse without wheel. The
mouse wheel works well if I use a 2.4 kernel series (probably, because
the X-window system is the one who handles the mouse wheel.). If you
need some more information mail me.

Thanks for all.

P.D.: Also, it would be great if the synaptics touchpad (or any other
touchpad) is disabled if other mouse is pluged into the same port.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbTIYFJu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 01:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbTIYFJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 01:09:50 -0400
Received: from babyruth.hotpop.com ([204.57.55.14]:55761 "EHLO
	babyruth.hotpop.com") by vger.kernel.org with ESMTP id S261693AbTIYFJt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 01:09:49 -0400
Subject: Re: [PATCH] 2.6: joydev is too eager claiming input devices
From: Dan <overridex@punkass.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
In-Reply-To: <200309242254.21630.dtor_core@ameritech.net>
References: <1064459037.19555.3.camel@nazgul.overridex.net>
	 <200309242254.21630.dtor_core@ameritech.net>
Content-Type: text/plain
Message-Id: <1064464279.20970.1.camel@nazgul.overridex.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 25 Sep 2003 00:31:20 -0400
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-24 at 23:54, Dmitry Torokhov wrote:
> Could you post contents of your /proc/bus/input/devices please?

Here's the gamepad's section:

I: Bus=0003 Vendor=046d Product=c20b Version=0060
N: Name="Logitech WingMan Action Pad"
P: Phys=usb-0000:02:00.0-1/input0
H: Handlers=
B: EV=b
B: KEY=1ff 1 0 0 0 0 0 0 0 0
B: ABS=30007

-Dan



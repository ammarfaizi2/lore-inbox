Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265272AbRGAT2S>; Sun, 1 Jul 2001 15:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265267AbRGAT2I>; Sun, 1 Jul 2001 15:28:08 -0400
Received: from fepout4.telus.net ([199.185.220.239]:53065 "EHLO
	priv-edtnes12-hme0.telusplanet.net") by vger.kernel.org with ESMTP
	id <S265264AbRGAT2D>; Sun, 1 Jul 2001 15:28:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Philip V. Neves" <pneves@telus.net>
Organization: pneves@ragingguppy.com
To: linux-kernel@vger.kernel.org
Subject: Possible problem with IDE device driver in kernel.
Date: Thu, 2 Jan 1997 23:35:39 -0800
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <97010223353900.00997@rasputan>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to report a bug that I've seen in a few linux kernels now. This 
may be a serious problem with the IDE controler software because it may cause 
a hard drive to ware out over a period of time. I've noticed for a long time 
that when linux is loaded the hard drive light on my computer goes on and 
stays on. It never turns off. If I boot with windows the light turns off. I 
think it may be the device driver that forgets to turn of the light. Could 
one of you please confirm if this is a problem with the kernel and get back 
to me if it is not. 

Thank you,


Philip V. Neves

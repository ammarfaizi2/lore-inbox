Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267397AbTAGPEq>; Tue, 7 Jan 2003 10:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267398AbTAGPEq>; Tue, 7 Jan 2003 10:04:46 -0500
Received: from dsl-64-129-133-253.telocity.com ([64.129.133.253]:43908 "EHLO
	cfowler.outpostsentinel.com") by vger.kernel.org with ESMTP
	id <S267397AbTAGPEq>; Tue, 7 Jan 2003 10:04:46 -0500
Subject: Extending PCI
From: cfowler <cfowler@outpostsentinel.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Jan 2003 10:15:58 -0500
Message-Id: <1041952559.32055.8.camel@cfowler.outpostsentinel.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have created a PCI extension adapter that extends a PCI port by 6
inches.  I'm using this to place a Comtrol Rocket PCI card in a 1U case.
The Rocketport driver in the kernel can see the card and detect the
number of ports on an external expansion box but I'm not getting data in
and out the ports.  All this works fine without the extension.  My
question is there a way in the driver or another part of the linux
kernel to change timings that will solve this problem?

Thanks,
Chris




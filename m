Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbTK2VWg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 16:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263945AbTK2VWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 16:22:36 -0500
Received: from pop.gmx.net ([213.165.64.20]:53442 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263942AbTK2VWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 16:22:35 -0500
X-Authenticated: #18350204
Subject: agpgart: error or info message?
From: Kleiner Hampel <kleiner_hampel@gmx.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1070140962.1372.10.camel@linux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 29 Nov 2003 22:22:42 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i have compiled AGP support and support for i81x chipsets in kernel.
My mainboard has a i815 chipset.
But while booting kernel, i get this message:

agpgart: Detected an Intel i815 Chipset, but could not find the
secondary device.
agpgart: Detected an Intel i815 Chipset.
agpgart: Maximum main memory to use for agp memory: 262M
agpgart: AGP aperture is 64M @ 0xf8000000

What does "but could not find the secondary device." mean?
Is anything going wrong?

regards,
hampel



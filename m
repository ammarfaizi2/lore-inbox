Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287386AbSBSWu0>; Tue, 19 Feb 2002 17:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289571AbSBSWuR>; Tue, 19 Feb 2002 17:50:17 -0500
Received: from sproxy.gmx.net ([213.165.64.20]:56400 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S287386AbSBSWuG>;
	Tue, 19 Feb 2002 17:50:06 -0500
Date: Tue, 19 Feb 2002 23:49:39 +0100
From: Hanno Boeck <hanno@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Problems with Radeon Framebuffer
Message-Id: <20020219234939.0d8597fb.hanno@gmx.de>
X-Mailer: Sylpheed version 0.7.1claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have Problems using the radeon Framebuffer on my Notebook. It is a Sony PCG-GR114MK with a Radeon Mobility.

Kernel shows the following message. It only works with vesa-framebuffer.

Feb 19 23:41:54 hannonb kernel: radeonfb: ref_clk=2700, ref_div=60, xclk=16600 from BIOS
Feb 19 23:41:54 hannonb kernel: radeonfb: panel ID string: 1024x768                
Feb 19 23:41:54 hannonb kernel: radeonfb: detected DFP panel size from BIOS: 1024x768
Feb 19 23:41:54 hannonb kernel: radeonfb: cannot map FB

Any ideas what I could do?

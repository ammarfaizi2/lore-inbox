Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266256AbSLIWih>; Mon, 9 Dec 2002 17:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266295AbSLIWih>; Mon, 9 Dec 2002 17:38:37 -0500
Received: from blount.mail.mindspring.net ([207.69.200.226]:60180 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S266256AbSLIWih>; Mon, 9 Dec 2002 17:38:37 -0500
Date: Mon, 9 Dec 2002 17:45:53 -0500
From: Daniel Franke <daniel@franke.homeip.net>
To: linux-kernel@vger.kernel.org
Subject: Radeon DRI w/ large memory
Message-ID: <20021209224553.GA469@silmaril>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently upgraded my memory to 1GB and compiled 4GB large memory support
into the kernel.  Now, my display freezes when I try to use DRI with my
ATI Radeon VE (Radeon 7000 chipset IIRC).  The machine is still responsive
to the LAN, but even if I kill X, the display remains frozen.  Disabling
large memory support makes the problem go away.

I can live without the extra 44MB of memory, but I'd really like to get this
fixed.  I vaguely remember hearing about a bug like this, but I have to
idea how to patch it.  I use 2.4.20-ac1 and my motherboard is a Gigabyte
GA-7VRX.

Thanks,
Daniel Franke

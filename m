Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262180AbSJZONw>; Sat, 26 Oct 2002 10:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262158AbSJZONw>; Sat, 26 Oct 2002 10:13:52 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:49837 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S262148AbSJZONv>;
	Sat, 26 Oct 2002 10:13:51 -0400
Date: Sat, 26 Oct 2002 16:20:02 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200210261420.QAA16144@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [UPDATE] version 3.0-pre3 of performance counters driver for 2.5.44
Cc: ak@muc.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

perfctr-3.0-pre3 has been released. The only significant change
from -pre2 is that the x86 driver's per-cpu cache now uses the
per_cpu() framework, as recommended by Andi Kleen.

The updated patch kit is available from
http://www.csd.uu.se/~mikpe/linux/perfctr/3.x/patchkit/

/Mikael

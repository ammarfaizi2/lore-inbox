Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311026AbSCWTsD>; Sat, 23 Mar 2002 14:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311092AbSCWTrx>; Sat, 23 Mar 2002 14:47:53 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:23202 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S311026AbSCWTrt>;
	Sat, 23 Mar 2002 14:47:49 -0500
Date: Sat, 23 Mar 2002 20:47:45 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200203231947.UAA23134@harpo.it.uu.se>
To: jmacbaine@yahoo.de
Subject: Re: ftape status in 2.4
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Mar 2002 17:50:59 +0100 (CET), jmacbaine@yahoo.de wrote:
>Is there currently a working version of ftape for
>2.4 kernels? The actual version look like it will
>only work with 2.2 kernels.

The one included in current 2.4 kernels should still work for most
ftape hardware. 2.5 has a minor but fixable compile problem due to
the virt_to_bus() interface change.

>Does nobody use those drives anymore?

They're not exactly popular, but I still use my old Seagate/Conner
TR-3 unit on a remote server.

/Mikael

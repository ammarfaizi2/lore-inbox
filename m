Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262904AbTCSCSa>; Tue, 18 Mar 2003 21:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262905AbTCSCSa>; Tue, 18 Mar 2003 21:18:30 -0500
Received: from bgp01360964bgs.sandia01.nm.comcast.net ([68.35.68.128]:19072
	"EHLO orion.dwf.com") by vger.kernel.org with ESMTP
	id <S262904AbTCSCS3>; Tue, 18 Mar 2003 21:18:29 -0500
Message-Id: <200303190229.h2J2TLhA001753@orion.dwf.com>
X-Mailer: exmh version 2.6.1 02/18/2003 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
From: clemens@dwf.com
Subject: Cant install printer / RH8.0 SMP kernel
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 18 Mar 2003 19:29:21 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Im seeing an odd problem when trying to install a printer
(either HP or Epson) on the parallel port of a SMP machine.

The printtool job runs and shows NO errors, but when you
are done, there is neither an /etc/printcap nor any files
below /var/spool/lpd.  Needless to say the test plot fails.

This is with the default RH8.0 SMP kernel (possibly updated
by up2date last week).

Is there a known problem with the RH kernel and printtool?
Everything there is provided as modules, I tried loading 
everything I could see that had to do with parallel ports,
still nothing.

My intention is to pull the sources for the 2.4.20 kernel
and build it myself (with these things NOT as modules) but
I would appreciate any insights into the problem.


-- 
                                        Reg.Clemens
                                        reg@dwf.com



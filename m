Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262130AbSKHPev>; Fri, 8 Nov 2002 10:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262184AbSKHPev>; Fri, 8 Nov 2002 10:34:51 -0500
Received: from 24-216-100-96.charter.com ([24.216.100.96]:10883 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id <S262130AbSKHPeu>;
	Fri, 8 Nov 2002 10:34:50 -0500
Date: Fri, 8 Nov 2002 10:41:32 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: installing modules to ($PREFIX)/lib/modules/2.....
Message-ID: <20021108154132.GC1319@rdlg.net>
Mail-Followup-To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



  I need to move the modules from a new kernel compile from my compile
machine to a production test.  Previously this has been done with some
rsync and diff magic.  The problem is the potential to kill the compile
server if a module is overwritten that is needed.

  I've compiled my kernel and modules but want to install the modules to
/tmp/lib/modules/2.4.18 so I can tar that up and move it to the server
in question.  Is there a system for doing this built into the kernel
compile structure I haven't found yet?

Robert



:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | PGP Key ID: FC96D405
                               
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.
FYI:
 perl -e 'print $i=pack(c5,(41*2),sqrt(7056),(unpack(c,H)-2),oct(115),10);'


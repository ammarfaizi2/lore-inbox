Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265880AbTBOVEd>; Sat, 15 Feb 2003 16:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266100AbTBOVEd>; Sat, 15 Feb 2003 16:04:33 -0500
Received: from franka.aracnet.com ([216.99.193.44]:18573 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265880AbTBOVEb>; Sat, 15 Feb 2003 16:04:31 -0500
Date: Sat, 15 Feb 2003 13:14:20 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 361] New: system hangs until keyrpress
Message-ID: <6930000.1045343660@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=361

           Summary: system hangs until keyrpress
    Kernel Version: 2.5.61
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: albertogonzales@hot.ee


Distribution: debian unstable/custom
Hardware Environment: 
compaq armada m700 mobile p3 with maestro 2e, 64 megs of ram.
Software Environment:
kernel 2.5.61 (having the same problem since 2.5.56+), gcc 3.2 and other
utils from debian/unstable.

Problem Description:
The machine locks up until an interrupt is received from keyboard.. the
mouse moves, display is frozen (xmms title stops rotating).network traffic
is received (i get a bunch of text after i press a key from irc). this
problem exists only when xmms is playing (oss emulation with alsa). after i
close xmms the hangup never occures. if playing mp3s with mpg123 everything
works.

Nasty bugs.. contact me for more information
Steps to reproduce:
have no idea.



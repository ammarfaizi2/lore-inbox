Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261640AbSK0HRQ>; Wed, 27 Nov 2002 02:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261644AbSK0HRQ>; Wed, 27 Nov 2002 02:17:16 -0500
Received: from s383.jpl.nasa.gov ([137.78.170.215]:15059 "EHLO
	s383.jpl.nasa.gov") by vger.kernel.org with ESMTP
	id <S261640AbSK0HRP>; Wed, 27 Nov 2002 02:17:15 -0500
Date: Tue, 26 Nov 2002 23:24:28 -0800 (PST)
From: Bryan B Whitehead <driver@huey.jpl.nasa.gov>
To: linux-kernel@vger.kernel.org
Subject: modutils 2.4.19/20/21/22 and kernel 2.5.48/49 errors
Message-ID: <Pine.GSO.4.21.0211262322290.10016-100000@s383.jpl.nasa.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't get modutils to work with the 2.5.48/49 kernel.

I get an error about QM_MODULES not being supported.

I've tried many versions of modutils all with the same problem... Do i
need a patch or some magic stuff needs to be passed to the configure
script?

Or do I just need to build everything into the kernel?

I don't care about backward compadibility with 2.4.x...

--
Bryan Whitehead
SysAdmin - JPL - Interferometry Systems and Technology
Phone: 818 354 2903
driver@jpl.nasa.gov




Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311482AbSCNCpt>; Wed, 13 Mar 2002 21:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311483AbSCNCph>; Wed, 13 Mar 2002 21:45:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54794 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311482AbSCNCpT>; Wed, 13 Mar 2002 21:45:19 -0500
Subject: Re: libc/1427: gprof does not profile threads <synopsis of the problem
To: dkegel@ixiacom.com (Dan Kegel)
Date: Thu, 14 Mar 2002 03:00:22 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), drepper@redhat.com (Ulrich Drepper),
        darkeye@tyrell.hu, libc-gnats@gnu.org, gnats-admin@cygnus.com,
        sam@zoy.org, Xavier.Leroy@inria.fr (Xavier Leroy),
        linux-kernel@vger.kernel.org, babt@us.ibm.com
In-Reply-To: <3C8FF822.D4F38B09@ixiacom.com> from "Dan Kegel" at Mar 13, 2002 05:08:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lLTa-0008BN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm all in favor of a userspace fix.  I suggested a patch
> to glibc to fix this.  Ulrich rejected it; I'm trying
> to coax out of him how he thinks profiling of multithreaded
> programs on Linux should be fixed.

Good and I'll reject any kernel patches 8)

If Ulrich won't talk then talk to the NGPT people. Maybe a little
competition will warm things up.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293643AbSCPB05>; Fri, 15 Mar 2002 20:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293648AbSCPB0s>; Fri, 15 Mar 2002 20:26:48 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12804 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293643AbSCPB0c>; Fri, 15 Mar 2002 20:26:32 -0500
Subject: Re: libc/1427: gprof does not profile threads <synopsis of the
To: drepper@redhat.com (Ulrich Drepper)
Date: Sat, 16 Mar 2002 01:41:26 +0000 (GMT)
Cc: dank@ixiacom.com (Dan Kegel), jakub@redhat.com (Jakub Jelinek),
        dkegel@ixiacom.com (Dan Kegel), darkeye@tyrell.hu, libc-gnats@gnu.org,
        gnats-admin@cygnus.com, sam@zoy.org,
        Xavier.Leroy@inria.fr (Xavier Leroy), linux-kernel@vger.kernel.org,
        babt@us.ibm.com (Bill Abt)
In-Reply-To: <1016237961.5612.51.camel@myware.mynet> from "Ulrich Drepper" at Mar 15, 2002 04:19:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16m3CI-0005Hd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Ulrich, do you at least agree that it would be desirable for
> > gprof to work properly on multithreaded programs?
> 
> No.  gprof is uselss in today world.

Now you know why I suggested talking to the NGPT people and the gprof
maintainer

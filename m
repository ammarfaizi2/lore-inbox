Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130528AbQKCOzc>; Fri, 3 Nov 2000 09:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130543AbQKCOzW>; Fri, 3 Nov 2000 09:55:22 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:38767 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S130528AbQKCOzD>; Fri, 3 Nov 2000 09:55:03 -0500
Message-Id: <200011031454.IAA92747@kenobi.americas.sgi.com>
To: linux-kernel@vger.kernel.org
From: kohnke@sgi.com (Marlys Kohnke)
cc: djh@sgi.com, watters@sgi.com, dwg@acl.lanl.gov
Subject: Linux job accounting demo next week
Date: Fri, 03 Nov 2000 08:54:58 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


     Linux job accounting will be demo'd at the SGI booth
next week at SuperComputing 2000 in Dallas.  I think 
the SGI and LANL lawyers are down to the last legal issue
to be resolved, and then the source will be available at
http://oss.sgi.com/projects/csa.

     We've got some testing to complete yet.  All of the
commands are ported, new i/o counters added to the kernel,
and disk accounting, daily and periodic reports are being
created.

     The demo systems are based off of linux 2.4.0-test7 with
patches for the job infrastructure and csa code.  Almost all of
the job accounting kernel work is done in a loadable module, so
the other kernel changes are small.

----
Marlys Kohnke			Silicon Graphics Inc.
kohnke@sgi.com			655F Lone Oak Drive
(651)683-5324			Eagan, MN 55121
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

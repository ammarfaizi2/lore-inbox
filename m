Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130443AbRCGIzS>; Wed, 7 Mar 2001 03:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130435AbRCGIzJ>; Wed, 7 Mar 2001 03:55:09 -0500
Received: from infis-gw.ts.infn.it ([140.105.7.230]:55300 "EHLO
	sole.infis.univ.trieste.it") by vger.kernel.org with ESMTP
	id <S130443AbRCGIyt>; Wed, 7 Mar 2001 03:54:49 -0500
Date: Wed, 7 Mar 2001 09:54:10 +0100 (CET)
From: Andrea Barisani <lcars@infis.univ.trieste.it>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.2 command execution hangs and then succeded after 2
 minutes....!?
Message-ID: <Pine.LNX.4.10.10103070944520.4593-100000@sole.infis.univ.trieste.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I've compiled and installd 2.4.2 on a my self-made linux distribution
based on glibc-2.0 and a strange thing happens. When I invoke some
binaries (for examples mc,pine,tar) for at least 2 minutes nothing
happens, the execution appaerntly hangs but then the command start as
normal. This happens only with a few set of commands that apparently have
nothing in common, they are linked against the same libraries of many
other commands that are working. I don't know what to think, I've used a
kernel compiled on an other machine (that is known to build correctly 
2.4.x kernels) but the problem remains so it is not my gcc-2.95 fault.

Does anyone has some ideas?

Bye 

-----------------------------------------------------------
NE&T               Network Administrator & Security Officer 
Area Science Park - S.S. 14 Km 163.5 Basovizza (TS) - Italy
lcars@newtech.it  - PGP Key 0x8E21FE82 - +39 040 3757938
-----------------------------------------------------------
"How would you know I'm mad?" said Alice.
"You must be,'said the Cat,'or you wouldn't have come here"
-----------------------------------------------------------


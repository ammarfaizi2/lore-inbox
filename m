Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbQLaEaP>; Sat, 30 Dec 2000 23:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129572AbQLaEaF>; Sat, 30 Dec 2000 23:30:05 -0500
Received: from clavin.efn.org ([206.163.176.10]:50893 "EHLO clavin.efn.org")
	by vger.kernel.org with ESMTP id <S129436AbQLaE3x>;
	Sat, 30 Dec 2000 23:29:53 -0500
From: Steve VanDevender <stevev@efn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14926.44784.275063.266417@tzadkiel.efn.org>
Date: Sat, 30 Dec 2000 19:58:40 -0800
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: multiple mount of devices possible 2.4.0-test1 -
In-Reply-To: <200012310348.eBV3mVA159133@saturn.cs.uml.edu>
In-Reply-To: <Pine.GSO.4.21.0012301829190.4082-100000@weyl.math.psu.edu>
	<200012310348.eBV3mVA159133@saturn.cs.uml.edu>
X-Mailer: VM 6.89 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan writes:
 > Alexander Viro writes:
 > 
 > > [...] Not allowing multiple mounts of the same
 > > fs was an artifact of original namei() implementation. At some point
 > > (late 80s) it had been fixed by Bell Labs folks in their branch. In Linux
 > > it had been fixed during the last spring. That's it. You were never promised
 > > that multiple mounts will not work. Moreover, in special cases they did work
 > 
 > Heh. :-)
 > 
 > 1. go to http://www.linuxcertification.com/resources/quizzes/
 > 2. take the "System Administration" quiz
 > 3. try answering question 6 correctly

Note: Chances are you won't get the same question 6 that Albert did.

Some poorly-written "certification" quiz shouldn't dictate what goes
into the kernel, either.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

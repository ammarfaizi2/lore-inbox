Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135849AbQLaETc>; Sat, 30 Dec 2000 23:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129572AbQLaETW>; Sat, 30 Dec 2000 23:19:22 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:6670 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129436AbQLaETM>;
	Sat, 30 Dec 2000 23:19:12 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200012310348.eBV3mVA159133@saturn.cs.uml.edu>
Subject: Re: PROBLEM: multiple mount of devices possible 2.4.0-test1 -
To: viro@math.psu.edu (Alexander Viro)
Date: Sat, 30 Dec 2000 22:48:31 -0500 (EST)
Cc: linux-kernel@ton.iguana.be (Ton Hospel), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0012301829190.4082-100000@weyl.math.psu.edu> from "Alexander Viro" at Dec 30, 2000 06:57:43 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:

> [...] Not allowing multiple mounts of the same
> fs was an artifact of original namei() implementation. At some point
> (late 80s) it had been fixed by Bell Labs folks in their branch. In Linux
> it had been fixed during the last spring. That's it. You were never promised
> that multiple mounts will not work. Moreover, in special cases they did work

Heh. :-)

1. go to http://www.linuxcertification.com/resources/quizzes/
2. take the "System Administration" quiz
3. try answering question 6 correctly
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

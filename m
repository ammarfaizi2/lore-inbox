Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S161111AbQHJRrs>; Thu, 10 Aug 2000 13:47:48 -0400
Received: by vger.rutgers.edu id <S161027AbQHJRqx>; Thu, 10 Aug 2000 13:46:53 -0400
Received: from chia.umiacs.umd.edu ([128.8.120.111]:46601 "EHLO chia.umiacs.umd.edu") by vger.rutgers.edu with ESMTP id <S160780AbQHJRpA>; Thu, 10 Aug 2000 13:45:00 -0400
Date: Thu, 10 Aug 2000 14:11:01 -0400 (EDT)
From: ADAM Sulmicki <adam@cfar.umd.edu>
To: linux-kernel@vger.rutgers.edu
Subject: [ot] machine independent protection from stack-smashing attack (fwd)
Message-ID: <Pine.GSO.4.21.0008101410010.18252-100000@chia.umiacs.umd.edu>
X-WEB: http://www.eax.com
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu


Not quite related to kernel development per see, but I though,
nevertheless it would be of interest to many folks here.

-- 
Adam
http://www.eax.com	The Supreme Headquarters of the 32 bit registers

---------- Forwarded message ----------
Date: Wed, 9 Aug 2000 18:59:49 +0900
From: Hiroaki Etoh <ETOH@JP.IBM.COM>
To: BUGTRAQ@SECURITYFOCUS.COM
Subject: machine independent protection from stack-smashing attack

I have been investigating a machine-independent change to GCC that
would generate code to protect applications from stack-smashing attacks.
The main characteristics are low performance overhead of the protection
code, protecting against different varieties of stack-smashing attacks,
and supporting various processors. A research report is ready on
the web (http://www.trl.ibm.co.jp/projects/security/propolice).

I would like some feedback whether it is worth pursuing getting it
assigned to the FSF for inclusion in GCC.

---
Hiroaki Etoh,  Tokyo Research Laboratory, IBM Japan


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/

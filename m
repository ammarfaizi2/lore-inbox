Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268952AbTBSQPo>; Wed, 19 Feb 2003 11:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268955AbTBSQPo>; Wed, 19 Feb 2003 11:15:44 -0500
Received: from mailman.xyplex.com ([140.179.176.116]:5860 "EHLO
	mailman.xyplex.com") by vger.kernel.org with ESMTP
	id <S268952AbTBSQPn>; Wed, 19 Feb 2003 11:15:43 -0500
Message-ID: <19EE6EC66973A5408FBE4CB7772F6F0A046AB5@ltnmail.xyplex.com>
From: "Dow, Benjamin" <bdow@mrv.com>
To: "'Alvaro Barbosa G.'" <alvaro.barbosa-g@ntlworld.com>,
       linux-kernel@vger.kernel.org
Subject: RE: make: *** No rule to make target `2'.  Stop
Date: Wed, 19 Feb 2003 11:23:41 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps there's a
make blah 2>&1
somewhere that's being misinterpreted (whether because you're using a
different shell, or something was mis-typed somewhere)

-----Original Message-----
From: Alvaro Barbosa G. [mailto:alvaro.barbosa-g@ntlworld.com]
Sent: Sunday, February 16, 2003 12:31 PM
To: linux-kernel@vger.kernel.org
Subject: make: *** No rule to make target `2'. Stop


Hi,


kernel-2.5.61-1
gcc-3.2.2-1

make: *** No rule to make target `2'.  Stop.

Any ideas?

thanks,
alvaro
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



 The information contained in this electronic mail is privileged and
confidential, intended only for the use of the individual or entity named
above. If the reader of this message is not the intended recipient, you are
hereby notified that any dissemination, distribution, copying or other use
of this communication is strictly prohibited. 

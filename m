Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <157405-25206>; Tue, 2 Mar 1999 12:32:01 -0500
Received: by vger.rutgers.edu id <157013-25206>; Tue, 2 Mar 1999 12:31:50 -0500
Received: from mail.blox.se ([195.7.73.197]:64503 "EHLO lix.blox.se" ident: "IDENT-NONSENSE") by vger.rutgers.edu with ESMTP id <157278-25208>; Tue, 2 Mar 1999 12:30:18 -0500
From: Bjorn Ekwall <bj0rn@blox.se>
Message-Id: <199903021837.TAA22258@lix.blox.se>
Subject: Getting close: modutils-snap990302
To: linux-kernel@vger.rutgers.edu
Date: Tue, 2 Mar 1999 19:36:59 +0100 (CET)
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: owner-linux-kernel@vger.rutgers.edu

Hi all,

After fixing (quite a few) problems, and after adding most Debian patches,
it's time for me to recommend you all to look at:

	<http://www.pi.se/blox/modutils/modutils-snap990302.tar.gz>

There might be some more Debian patches added, and some documentation
updates, otherwise I think it is done...
For example, I think that "modprobe -r" now is usable for crontab
to clean up "autoclean"-able modules while still performing the
pre-/post-remove commands in /etc/conf.modules.

Prove me wrong!

Björn Ekwall <bj0rn@blox.se>


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/

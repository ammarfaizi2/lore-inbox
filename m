Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S157008AbQGQTBe>; Mon, 17 Jul 2000 15:01:34 -0400
Received: by vger.rutgers.edu id <S157028AbQGQTAW>; Mon, 17 Jul 2000 15:00:22 -0400
Received: from [216.18.11.193] ([216.18.11.193]:7449 "HELO duke.electric.net") by vger.rutgers.edu with SMTP id <S157185AbQGQS6V>; Mon, 17 Jul 2000 14:58:21 -0400
From: Chester Carey <ccarey@intrinsyc.com>
Organization: Intrinsyc
To: linux-kernel@vger.rutgers.edu
Subject: NFS root
Date: Mon, 17 Jul 2000 12:10:28 -0700
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <00071712143500.29824@ccarey>
Content-Transfer-Encoding: 7BIT
Sender: owner-linux-kernel@vger.rutgers.edu

Hi everyone, I am currently trying to get a NFS root file system working on an
embedded device. Everything seems to go fine until I get to init, it trys to run
init and then nothing (no kernel messages or anything else). The ramdisk works
fine when booted from memeory rather than NFS. Has anyone had a similar problem
or does anyone know a fix for this

Chester Carey
Intrinsyc Software 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/

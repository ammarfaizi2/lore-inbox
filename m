Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S153985AbPGTKzg>; Tue, 20 Jul 1999 06:55:36 -0400
Received: by vger.rutgers.edu id <S153970AbPGTKzR>; Tue, 20 Jul 1999 06:55:17 -0400
Received: from hera.cwi.nl ([192.16.191.1]:55041 "EHLO hera.cwi.nl") by vger.rutgers.edu with ESMTP id <S153929AbPGTKy5>; Tue, 20 Jul 1999 06:54:57 -0400
Date: Tue, 20 Jul 1999 12:54:54 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC199907201054.MAA21390.aeb@papegaai.cwi.nl>
To: linux-kernel@vger.rutgers.edu
Subject: util-linux-2.9v
Sender: owner-linux-kernel@vger.rutgers.edu

I just put util-linux-2.9v the usual places.
People complained that using *fdisk failed on 600 GB disks.
If I made no mistake cfdisk will now work up to 2 TB
(mainly by ignoring the kernel's answer to HDGETGEO).

Once 2 TB looked almost infinitely large, but today
100 GB is quite common, and we can expect that very soon
this 2 TB will be a real limit. In other words, this old
ugly DOS-type partition table will have to be replaced.

Andries

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/

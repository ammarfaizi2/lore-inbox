Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273333AbRJPHM4>; Tue, 16 Oct 2001 03:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273349AbRJPHMq>; Tue, 16 Oct 2001 03:12:46 -0400
Received: from goliath.htl-leonding.ac.at ([193.170.156.11]:43409 "EHLO
	goliath.htl-leonding.ac.at") by vger.kernel.org with ESMTP
	id <S273333AbRJPHMa>; Tue, 16 Oct 2001 03:12:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Alram Lechner <a.lechner@htl-leonding.ac.at>
Reply-To: a.lechner@htl-leonding.ac.at
Organization: HTL-Leonding
To: linux-kernel@vger.kernel.org
Subject: Asus CUR-DLS (ServerWorks) SMP Hang up
Date: Tue, 16 Oct 2001 09:16:45 +0200
X-Mailer: KMail [version 1.2]
Cc: a.lechner@mail.htl-leonding.ac.at
MIME-Version: 1.0
Message-Id: <01101609164500.28366@goliath.htl-leonding.ac.at>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

i have the following hardware:
Asus CUR-DLS with ServerWorks Chip
2x P III 800 MHz
3x256 ECC RAM
ATI Rage XL
Symbios 53c1010

and the followin problem:
the system wil hang with two processors when i copy
about 300 MB (files or one file) from one HDD to another.
there is a complete hang up.

i tried the following:
change the Symbios 53c1010 to a Adaptec 29160
copied from from SCSI to SCSI, IDE to SCSI, IDE to IDE
probed the following kernel:
RedHat 7.1 standard, RH 7.1 iwth XFS standard, (v 1.0 and 1.0.1)
2.4.2, 2.4.2 with xfs, 2.4.5, 2.4.5 with xfs, 2.4.12 with xfs
and i have always the same problem.

is there anybody who has this board an can say it works with
2 cpu's?


thanks

alram lechner



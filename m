Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312888AbSDOFqa>; Mon, 15 Apr 2002 01:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312895AbSDOFq3>; Mon, 15 Apr 2002 01:46:29 -0400
Received: from 137-5.red-dsl.cpl.net ([192.216.137.5]:26897 "HELO
	mail.heronforge.net") by vger.kernel.org with SMTP
	id <S312888AbSDOFq3>; Mon, 15 Apr 2002 01:46:29 -0400
Date: Sun, 14 Apr 2002 22:46:24 -0700 (PDT)
From: Stephen Carville <carville@cpl.net>
X-X-Sender: <stephen@warlock.heronforge.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Assertion Failure
Message-ID: <Pine.LNX.4.33.0204142226300.28965-100000@warlock.heronforge.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sunday, the DBA was importing data into an Oracle 9i database when the
system just stopped responding.  Anyone have an idea what this means
and how to fix it:

jordan kernel: Assertion failure in journal_bmap_Rsmp_1330f299() at
journal.c:602: "ret != 0"

The system:

Dell 2550
1 Ghz PIII (X2)
1024 Meg RAM
Adaptec aic7899 SCSI adapter
FUJITSU  MAJ3364MC drices (X5)
Redhat 7.2 (security fixes only)
2.4.7 kernel

I am not a member of this list so please CC me any answers.

-- 
-- Stephen Carville http://www.heronforge.net/~stephen/gnupgkey.txt


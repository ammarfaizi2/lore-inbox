Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318275AbSGXIVm>; Wed, 24 Jul 2002 04:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318276AbSGXIVm>; Wed, 24 Jul 2002 04:21:42 -0400
Received: from signup.localnet.com ([207.251.201.46]:41468 "HELO
	smtp.localnet.com") by vger.kernel.org with SMTP id <S318275AbSGXIVl>;
	Wed, 24 Jul 2002 04:21:41 -0400
To: linux-kernel@vger.kernel.org
Cc: bitkeeper-users@bitmover.com
Subject: bk://linux.bkbits.net/linux-2.[45] pull error
From: "James H. Cloos Jr." <cloos@jhcloos.com>
Date: 24 Jul 2002 04:24:51 -0400
Message-ID: <m37kjlmt2k.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting this all of a sudden:

:; cd linux-2.4
:; bk parent
Parent repository is bk://linux.bkbits.net/linux-2.4
:; bk pull
---------------------- Receiving the following csets -----------------------
1.652 1.651 1.650 1.649 1.648 
----------------------------------------------------------------------------
ChangeSet fnext: No such file or directory

=================================== ERROR ====================================
takepatch: missing checksum line in patch, aborting.
==============================================================================

666 bytes uncompressed to 1222, 1.83X expansion
:; cd ../linux-2.5
:; bk parent
Parent repository is bk://linux.bkbits.net/linux-2.5
:; bk pull 
---------------------- Receiving the following csets -----------------------
1.684 1.683 1.681.1.1 1.682 1.681 1.680 1.679 1.678 1.677
1.676 1.675 1.674 1.673 1.672 1.671 1.670 1.669 1.668 1.667
1.666 
----------------------------------------------------------------------------
ChangeSet fnext: No such file or directory

=================================== ERROR ====================================
takepatch: missing checksum line in patch, aborting.
==============================================================================

344 bytes uncompressed to 710, 2.06X expansion



Is this a bkbits issue or something wrong on my side?

-JimC


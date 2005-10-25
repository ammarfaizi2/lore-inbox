Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbVJYQpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbVJYQpH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 12:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbVJYQpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 12:45:06 -0400
Received: from bromo.msbb.uc.edu ([129.137.3.146]:40675 "HELO
	bromo.msbb.uc.edu") by vger.kernel.org with SMTP id S932204AbVJYQpF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 12:45:05 -0400
To: linux-kernel@vger.kernel.org
Subject: W2100Z Critical temperature explained
Message-Id: <20051025164339.431C81DC06D@bromo.msbb.uc.edu>
Date: Tue, 25 Oct 2005 12:43:39 -0400 (EDT)
From: howarth@bromo.msbb.uc.edu (Jack Howarth)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

     Has anyone else run into the following problem with the 2.6.12
or 2.6.13 kernels on a Sun W2100Z dual opteron workstation? I found
that the Fedora Core 4 kernel 2.6.12-1.1456_FC4smp was causing random
shutdowns with error messages that 'Critical Temperature was reached: 68 C'.
This was occuring repeatedly under that kernel. After switching to the
latest FC4 kernel, 2.6.13-1.1532_FC4smp, these temperature events seemed
to have been eliminated for now. 
     However in calling the Sun Java Desktop support group, I was told
that the earlier BIOS versions on the W2100Z had bugs that can cause the
errors I was seeing as well as causing the cpu fans to self destruct.
The fix is apparently to upgrade the BIOS to the current one on their
Supplemental 2.1 CD. Is there some site this sort of information should
be added to? Perhaps Linux would be well served if there was a list of
motherboard BIOS kept and noted added regarding compatibility with
various Linux kernels. Certainly in cases like these where destruction
can occur due to the bugs in the firmware, this merits being passed
along to the Linux kernel users.
                     Jack



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129183AbQKYKhF>; Sat, 25 Nov 2000 05:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129228AbQKYKgz>; Sat, 25 Nov 2000 05:36:55 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:36798 "EHLO
        smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
        id <S129183AbQKYKgr>; Sat, 25 Nov 2000 05:36:47 -0500
To: buhr@stat.wisc.edu (Kevin Buhr)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test5 bug: invalid "shmid_kernel" passed to "shm_nopage_core"
In-Reply-To: <vbaaeapf4ti.fsf@mozart.stat.wisc.edu>
From: Christoph Rohland <cr@sap.com>
Date: 25 Nov 2000 11:05:45 +0100
In-Reply-To: buhr@stat.wisc.edu's message of "24 Nov 2000 15:17:13 -0600"
Message-ID: <m3g0kggydi.fsf@linux.local>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

buhr@stat.wisc.edu (Kevin Buhr) writes:
> The SHM locking has thwarted my attempts at understanding.  Maybe
> someone else can see the bug or reassure me that it's already been
> fixed in test11?

This is the first report of such corruption. If it's real it is _not_
fixed between test5 and test11. There is probably no way to reproduce
it since you ask if it's fixed in test11, right?

        Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

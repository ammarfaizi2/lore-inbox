Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268684AbTBZIgP>; Wed, 26 Feb 2003 03:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268686AbTBZIgP>; Wed, 26 Feb 2003 03:36:15 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49192 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S268684AbTBZIgO>; Wed, 26 Feb 2003 03:36:14 -0500
To: davidm@hpl.hp.com
Cc: David Lang <david.lang@digitalinsight.com>,
       Gerrit Huizenga <gh@us.ibm.com>, Benjamin LaHaise <bcrl@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
References: <E18moa2-0005cP-00@w-gerrit2>
	<Pine.LNX.4.44.0302222354310.8609-100000@dlang.diginsite.com>
	<15961.7487.465791.980935@napali.hpl.hp.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 26 Feb 2003 01:46:02 -0700
In-Reply-To: <15961.7487.465791.980935@napali.hpl.hp.com>
Message-ID: <m1bs0zmnud.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger <davidm@napali.hpl.hp.com> writes:

> >>>>> On Sun, 23 Feb 2003 00:07:50 -0800 (PST), David Lang
> <david.lang@digitalinsight.com> said:
> 
> 
>   David.L> Garrit, you missed the preior posters point. IA64 had the
>   David.L> same fundamental problem as the Alpha, PPC, and Sparc
>   David.L> processors, it doesn't run x86 binaries.
> 
> This simply isn't true.  Itanium and Itanium 2 have full x86 hardware
> built into the chip (for better or worse ;-).  The speed isn't as good
> as the fastest x86 chips today, but it's faster (~300MHz P6) than the
> PCs many of us are using and it certainly meets my needs better than
> any other x86 "emulation" I have used in the past (which includes
> FX!32 and its relatives for Alpha).

I have various random x86 binaries that do not work.

My 32bit x86 user space does not run.

A 32bit kernel doesn't have a chance.

So for me at least the 32bit support is not useful in avoiding
converting binaries.  For the handful of apps that cannot be
recompiled I suspect the support is good enough so you can get them
to run somehow.

Eric

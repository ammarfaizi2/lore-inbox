Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289230AbSBEQzP>; Tue, 5 Feb 2002 11:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289372AbSBEQyy>; Tue, 5 Feb 2002 11:54:54 -0500
Received: from ns.caldera.de ([212.34.180.1]:13289 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S289230AbSBEQyn>;
	Tue, 5 Feb 2002 11:54:43 -0500
Date: Tue, 5 Feb 2002 17:54:32 +0100
Message-Id: <200202051654.g15GsWH01780@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: dipankar@in.ibm.com (Dipankar Sarma)
Cc: Andrea Arcangeli <andrea@suse.de>, Rusty Russell <rusty@rustcorp.com.au>,
        Paul McKenney <paul.mckenney@us.ibm.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] New Read-Copy Update patch
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20020205211826.B32506@in.ibm.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.13 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020205211826.B32506@in.ibm.com> you wrote:
> 3. A per-cpu timer support ? - This will allow us to get rid of the krcud
>    stuff and make RCU even simpler.

Something like http://people.redhat.com/mingo/scalable-timers-patches/smptimers-2.4.16-A0?

Ingo, Linus:  Any chance to see that in 2.5 soon?

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288811AbSBIJzl>; Sat, 9 Feb 2002 04:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288804AbSBIJz3>; Sat, 9 Feb 2002 04:55:29 -0500
Received: from sun.fadata.bg ([80.72.64.67]:15115 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S288811AbSBIJzZ>;
	Sat, 9 Feb 2002 04:55:25 -0500
To: Rob Landley <landley@trommello.org>
Cc: Andrew Morton <akpm@zip.com.au>, Larry McVoy <lm@bitmover.com>,
        Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [bk patch] Make cardbus compile in -pre4
In-Reply-To: <Pine.LNX.4.33.0202081824070.25114-100000@segfault.osdlab.org>
	<20020208211257.F25595@work.bitmover.com>
	<3C64B451.3BC4B0CE@zip.com.au>
	<20020209093520.XVXR9607.femail47.sdc1.sfba.home.com@there>
X-No-CC: Reply to lists, not to me.
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <20020209093520.XVXR9607.femail47.sdc1.sfba.home.com@there>
Date: 09 Feb 2002 11:57:20 +0200
Message-ID: <877kpnt1tr.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Rob" == Rob Landley <landley@trommello.org> writes:

Rob> Optimizing the bandwidth of Linus and optimizing for the rest of the 
Rob> developer community are two seperate problems which may require two seperate 
Rob> toolchains.  Posting a patch to the list already isn't enough to get it to 
Rob> Linus.  Hasn't been for a while...

Yeah, right, and now people hope that commiting to some obscure
repository will be enough get it to Linus ?

Lemme tell ya, the result is that it won't get not only to Linus, but
to the majority of the community.

Sorry, hoping that some _tool_ will solve the (supposed) problems in
the kernel development is just plain stupid.

Regards,
-velco

PS. Interesting trend to note is the usually the amount of whining is
inversely proportional to one's contribution to the kernel.

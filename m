Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289806AbSAWLqh>; Wed, 23 Jan 2002 06:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289812AbSAWLqe>; Wed, 23 Jan 2002 06:46:34 -0500
Received: from ccs.covici.com ([209.249.181.196]:25984 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S289806AbSAWLqF>;
	Wed, 23 Jan 2002 06:46:05 -0500
Date: Wed, 23 Jan 2002 06:45:52 -0500 (EST)
From: John Covici <covici@ccs.covici.com>
To: Eli Zaretskii <eliz@is.elta.co.il>
cc: emacs-devel@gnu.org, <linux-kernel@vger.kernel.org>
Subject: Re: reading a file in emacs crashes 2.4.17 and 18-pre4
In-Reply-To: <Pine.SUN.3.91.1020123121537.6845Z-100000@is>
Message-ID: <Pine.LNX.4.40.0201230644480.3823-100000@ccs.covici.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I reconfigured my kernel to lie to it and say k6 for the processor
family instead of k7.

On Wed, 23 Jan 2002, Eli Zaretskii wrote:

>
> On Wed, 23 Jan 2002, John Covici wrote:
>
> > Well, I have worked around this problem by getting rid of the Athlon
> > optimizations so I guess there is still more work to do on those.
>
> Could you please tell what did you change, exactly?  It might be that
> this information should be in etc/PROBLEMS, in case other users bump into
> the same problem.
>

-- 
         John Covici
         covici@ccs.covici.com


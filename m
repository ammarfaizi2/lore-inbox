Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289757AbSAWKLd>; Wed, 23 Jan 2002 05:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289759AbSAWKLY>; Wed, 23 Jan 2002 05:11:24 -0500
Received: from ccs.covici.com ([209.249.181.196]:12160 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S289761AbSAWKLN>;
	Wed, 23 Jan 2002 05:11:13 -0500
To: emacs-devel@gnu.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: reading a file in emacs crashes 2.4.17 and 18-pre4
In-Reply-To: <m38zardsps.fsf@ccs.covici.com>
From: John Covici <covici@ccs.covici.com>
Date: Wed, 23 Jan 2002 05:11:09 -0500
In-Reply-To: <m38zardsps.fsf@ccs.covici.com> (John Covici's message of "Mon,
 21 Jan 2002 21:28:47 -0500")
Message-ID: <m3elkh2x8i.fsf@ccs.covici.com>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.2.50
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I have worked around this problem by getting rid of the Athlon
optimizations so I guess there is still more work to do on those.

on Mon, 21 Jan 2002 21:28:47 -0500 John Covici <covici@ccs.covici.com> wrote:

> Its a small file and was actually an accident, but you get all sorts
> of unable to handle kernel paging ... and eventually a kernel panic
> because it was trying to kill the idle process.
>
> I am using emacs version "21.2.50.1" and I have 1.4ghz Athlon and 256
> m of memory.

-- 
         John Covici
         covici@ccs.covici.com

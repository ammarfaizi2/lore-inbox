Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289761AbSAWKRx>; Wed, 23 Jan 2002 05:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289762AbSAWKRn>; Wed, 23 Jan 2002 05:17:43 -0500
Received: from is.elta.co.il ([199.203.121.2]:42669 "EHLO is.elta.co.il")
	by vger.kernel.org with ESMTP id <S289761AbSAWKRX>;
	Wed, 23 Jan 2002 05:17:23 -0500
Date: Wed, 23 Jan 2002 12:16:23 +0200 (IST)
From: Eli Zaretskii <eliz@is.elta.co.il>
To: John Covici <covici@ccs.covici.com>
cc: emacs-devel@gnu.org, linux-kernel@vger.kernel.org
Subject: Re: reading a file in emacs crashes 2.4.17 and 18-pre4
In-Reply-To: <m3elkh2x8i.fsf@ccs.covici.com>
Message-ID: <Pine.SUN.3.91.1020123121537.6845Z-100000@is>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Jan 2002, John Covici wrote:

> Well, I have worked around this problem by getting rid of the Athlon
> optimizations so I guess there is still more work to do on those.

Could you please tell what did you change, exactly?  It might be that 
this information should be in etc/PROBLEMS, in case other users bump into 
the same problem.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267725AbTBJMhH>; Mon, 10 Feb 2003 07:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267811AbTBJMhH>; Mon, 10 Feb 2003 07:37:07 -0500
Received: from sun.fadata.bg ([80.72.64.67]:34452 "EHLO freon")
	by vger.kernel.org with ESMTP id <S267725AbTBJMhH>;
	Mon, 10 Feb 2003 07:37:07 -0500
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Dave Jones <davej@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] gcc 2.95 vs 3.21 performance
References: <336780000.1044313506@flay> <20030204132048.D16744@suse.de>
	<172980000.1044373858@[10.10.2.4]>
X-No-CC: Reply to lists, not to me.
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <172980000.1044373858@[10.10.2.4]>
Date: 10 Feb 2003 14:13:08 +0200
Message-ID: <87y94owcyz.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Martin" == Martin J Bligh <mbligh@aracnet.com> writes:

    Martin> But the point is still the same ... even if it is doing
    Martin> more agressive optimisation, it's not actually buying us
    Martin> anything (at least for the kernel)

which might be due in part to ``-fno-strict-aliasing'' used to compile
the Linux kernel.

~velco

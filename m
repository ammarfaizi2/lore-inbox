Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312823AbSDBI1Z>; Tue, 2 Apr 2002 03:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312824AbSDBI1Q>; Tue, 2 Apr 2002 03:27:16 -0500
Received: from www.wen-online.de ([212.223.88.39]:46856 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S312823AbSDBI07>;
	Tue, 2 Apr 2002 03:26:59 -0500
Date: Tue, 2 Apr 2002 09:28:51 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: -aa VM splitup
In-Reply-To: <20020401200202.Q1331@dualathlon.random>
Message-ID: <Pine.LNX.4.10.10204020916560.313-100000@mikeg.wen-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Apr 2002, Andrea Arcangeli wrote:

> ........ can you try 2.4.19pre5aa1 first?

Ok, I tested (and repeated for consistancy to prevent repeat of
unfortunate premature results) 2.4.19-pre5 and 2.4.19pre5aa1.
I didn't get my write throughput back (oh well), but I do NOT
see any bad behavior.  IO looks/feels good in both kernels.

Only thing interesting during testing was that 2.4.19pre5aa1
lost by a consistant ~15% in the move a tree around test.

(if I find anything interesting on the 2.5 thingy, I'll let you
know offline)

	-Mike


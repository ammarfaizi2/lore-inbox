Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266643AbSLPL5h>; Mon, 16 Dec 2002 06:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266650AbSLPL5h>; Mon, 16 Dec 2002 06:57:37 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:4356 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id <S266643AbSLPL5g>;
	Mon, 16 Dec 2002 06:57:36 -0500
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, bcollins@debian.org,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: Linux v2.5.52
References: <Pine.LNX.4.44.0212151930120.12906-100000@penguin.transmeta.com>
	<20021216102639.A27589@infradead.org>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <20021216102639.A27589@infradead.org>
Date: 16 Dec 2002 07:05:24 -0500
Message-ID: <m37keagoe3.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "CH" == Christoph Hellwig <hch@infradead.org> writes:

Linus> Ben Collins <bcollins@debian.org>: o IEEE-1394/Firewire update

CH> This merge looks fishy.  It seems to be yet another let's throw my CVS
CH> repo in merge and backs out Al's work yo get rid of lots of devfs crap.

FWIW (which may be little) the ieee1394 code in 2.5.51 simply does not
work and the svn tree (same code as in 2.5.52) does.  For those of us
who depend on sbp2 for day-to-day functionality it makes current 2.5
possible....

That said, less divergence between Linus' bk tree and linux1394.org's
svn tree would be welcome.

-JimC


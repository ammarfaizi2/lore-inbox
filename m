Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRAHUfF>; Mon, 8 Jan 2001 15:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129735AbRAHUe4>; Mon, 8 Jan 2001 15:34:56 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:6119 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S129562AbRAHUen>; Mon, 8 Jan 2001 15:34:43 -0500
Date: Mon, 8 Jan 2001 22:33:44 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Linux-2.4.x patch submission policy
Message-ID: <20010108223343.O10035@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <937neu$p95$1@penguin.transmeta.com> <Pine.LNX.4.21.0101071434370.21675-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0101071434370.21675-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Sun, Jan 07, 2001 at 02:37:47PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2001 at 02:37:47PM -0200, Rik van Riel wrote:
> Once we are sure 2.4 is stable for just about anybody I
> will submit some of the really trivial enhancements for
> inclusion; all non-trivial patches I will maintain in a
> VM bigpatch, which will be submitted for inclusion around
> 2.5.0 and should provide one easy patch for those distribution
> vendors who think 2.4 VM performance isn't good enough for
> them ;)

Hmm, could you instead follow Andreas approach and have a
directory with little patches, that do _exactly_ one thing and a
file along to describe what is related, dependend and what each
patch does?

So people could try to suit them to their needs.

And they can tell you exactly _what_ change breaks instead of "It
doesn't work".

Thanks & Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

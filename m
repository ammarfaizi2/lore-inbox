Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316334AbSETUHD>; Mon, 20 May 2002 16:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316340AbSETUHC>; Mon, 20 May 2002 16:07:02 -0400
Received: from holomorphy.com ([66.224.33.161]:32904 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316334AbSETUHC>;
	Mon, 20 May 2002 16:07:02 -0400
Date: Mon, 20 May 2002 13:06:36 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Andrew Morton <akpm@zip.com.au>, Andrea Arcangeli <andrea@suse.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Bug with shared memory.
Message-ID: <20020520200636.GC2046@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@conectiva.com.br>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Andrew Morton <akpm@zip.com.au>, Andrea Arcangeli <andrea@suse.de>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <1232903251.1021886554@[10.10.2.3]> <Pine.LNX.4.44L.0205201630050.24352-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2002 at 04:38:15PM -0300, Rik van Riel wrote:
> I think good statistics to start would be the traditional
> page fault rate (pf), page free rate (fr), page scan rate
> (sr), reclaims (re), pageout (po), pagein (pi) and some
> variation of iowait stats.

This has been on my TODO list for months. Sorry I haven't gotten
around to it sooner. I'll follow up with that in a bit.


Cheers,
Bill

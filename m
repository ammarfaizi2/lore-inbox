Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312317AbSDJBDS>; Tue, 9 Apr 2002 21:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312320AbSDJBDR>; Tue, 9 Apr 2002 21:03:17 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:27635
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S312317AbSDJBDR>; Tue, 9 Apr 2002 21:03:17 -0400
Date: Tue, 9 Apr 2002 18:05:29 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Adam McKenna <adam-dated-1018827432.0ef497@flounder.net>
Cc: David Lang <david.lang@digitalinsight.com>, linux-kernel@vger.kernel.org
Subject: Re: The latest -ac patch to the stable Linux kernels
Message-ID: <20020410010529.GC23513@matchmail.com>
Mail-Followup-To: Adam McKenna <adam-dated-1018827432.0ef497@flounder.net>,
	David Lang <david.lang@digitalinsight.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020409233710.GD22300@flounder.net> <Pine.LNX.4.44.0204091646380.28293-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2002 at 04:47:47PM -0700, David Lang wrote:
> all the -ac kernels need to be treated as -pre
>

Exactly.

> if you watch in detail you can pick ones that are more likly to be stable
> then others, but some of them will be intentionally cutting edge.
> 

Alan does have a track record of stable kernels, but his tree does have
quite a lot of experimental patches in it.  He does warn about patches that
could be quite bad though (think ide and the recent suspend patches).

In fact, I'm using some -ac kernels in production after it has survived on
my workstation for a while and there haven't been any bug reports for the
stuff I use...

Also, 2.4.18 is the first time that I've seen Alan have -ac patches directly
against 2.4.xx instead of 2.4.xx-pre.  Unless he says otherwise I wouldn't
expect that to happen again.

Mike

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310713AbSCHHig>; Fri, 8 Mar 2002 02:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310714AbSCHHi0>; Fri, 8 Mar 2002 02:38:26 -0500
Received: from boden.synopsys.com ([204.176.20.19]:43993 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S310713AbSCHHiS>; Fri, 8 Mar 2002 02:38:18 -0500
Date: Fri, 8 Mar 2002 08:37:58 +0100
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM: When does CVS fall down where it REALLY matters?
Message-ID: <20020308083758.A4573@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C87FD12.8060800@greshamstorage.com> <Pine.LNX.4.44L.0203072057510.2181-100000@imladris.surriel.com> <3C880541.E04EFAB3@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C880541.E04EFAB3@zip.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 04:26:41PM -0800, Andrew Morton wrote:
...
> 
> Current tkdiff is in fact very good at this.  So integration
> with that may suit.
> 
> The problem I find is that I often want to take (file1+patch) -> file2,
> when I don't have file1.  But merge tools want to take (file1|file2) -> file3.
> I haven't seen a graphical tool which helps you to wiggle a patch into
> a file.
> 
Try vimdiff/gvimdiff from VIM 6.0. I think it does pretty good that job
(wiggle... what a word :)
-alex


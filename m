Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282919AbRK0LiH>; Tue, 27 Nov 2001 06:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282918AbRK0Lh5>; Tue, 27 Nov 2001 06:37:57 -0500
Received: from ns.ithnet.com ([217.64.64.10]:59660 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S282916AbRK0Lhq>;
	Tue, 27 Nov 2001 06:37:46 -0500
Date: Tue, 27 Nov 2001 12:37:24 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net,
        torvalds@transmeta.com, andrea@suse.de
Subject: Re: VM tests on 5 recent kernels
Message-Id: <20011127123724.04df2308.skraw@ithnet.com>
In-Reply-To: <20011127021513.A228@earthlink.net>
In-Reply-To: <20011127021513.A228@earthlink.net>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2001 02:15:13 -0500
rwhron@earthlink.net wrote:

> 
> 5 recent kernels:
> 
> mtest01		Averages for 10 mtest01 runs
> -------
> mtest01 allocates and writes to 80% of virtual memory.
> Listen to mp3 sampled at 128k.
> 
> mp3 on 2.4.16 skipped more than 2.4.15-pre6.
> 2.4.15-pre6 and 2.5.1-pre1 did best.  (fastest time, highest mp3 play).  
> 2.4.16-vm is a patch from http://surriel.com/patches/ 

I am pretty astonished about the differences between 2.4.16 and 2.5.1-pre1. Can
anybody point out some relevant difference between the two regarding such a
test case?

Regards,
Stephan


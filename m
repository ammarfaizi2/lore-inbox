Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288019AbSAHNiE>; Tue, 8 Jan 2002 08:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288021AbSAHNhz>; Tue, 8 Jan 2002 08:37:55 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:8196 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S288019AbSAHNhh>;
	Tue, 8 Jan 2002 08:37:37 -0500
Date: Wed, 9 Jan 2002 00:33:35 +1100
From: Anton Blanchard <anton@samba.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Luigi Genoni <kernel@Expansa.sns.it>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020108133335.GB26307@krispykreme>
In-Reply-To: <20020108030420Z287595-13997+1799@vger.kernel.org> <Pine.LNX.4.33.0201081153310.29480-100000@Expansa.sns.it> <20020108142117.F3221@inspiron.school.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020108142117.F3221@inspiron.school.suse.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> So yes, mean latency will decrease with preemptive kernel, but your CPU
> is definitely paying something for it.

And Andrew Morton's work suggests he can do a much better job of
reducing latency than -preempt.

Anton

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131261AbRCWRWJ>; Fri, 23 Mar 2001 12:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131297AbRCWRV7>; Fri, 23 Mar 2001 12:21:59 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:4376 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S131261AbRCWRVs>;
	Fri, 23 Mar 2001 12:21:48 -0500
Message-ID: <20010323182105.C6487@win.tue.nl>
Date: Fri, 23 Mar 2001 18:21:05 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Rik van Riel <riel@conectiva.com.br>,
        Michael Peddemors <michael@linuxmagic.com>,
        Stephen Clouse <stephenc@theiqgroup.com>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <20010323015358Z129164-406+3041@vger.kernel.org> <Pine.LNX.4.21.0103230403370.29682-100000@imladris.rielhome.conectiva> <20010323122815.A6428@win.tue.nl> <m1hf0k1qvi.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <m1hf0k1qvi.fsf@frodo.biederman.org>; from Eric W. Biederman on Fri, Mar 23, 2001 at 07:50:25AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2001 at 07:50:25AM -0700, Eric W. Biederman wrote:

> > Mar 23 11:48:49 mette kernel: Out of Memory: Killed process 2019 (emacs).
> > Mar 23 11:48:49 mette kernel: Out of Memory: Killed process 1407 (emacs).
> > Mar 23 11:48:50 mette kernel: Out of Memory: Killed process 1495 (emacs).
> > Mar 23 11:48:50 mette kernel: Out of Memory: Killed process 2800 (rpm).
> > 
> > [yes, that was rpm growing too large, taking a few emacs sessions]
> > [2.4.2]
> 
> Let me get this straight you don't have enough swap for your workload?
> And you don't have per process limits on root by default?
> 
> So you are complaining about the OOM killer?  

I should not react - your questions are phrased rhetorically.

But yes, I am complaining because Linux by default is unreliable.
I strongly prefer a system that is reliable by default,
and I'll leave it to others to run it in an unreliable mode.

Andries

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261369AbTCGFs1>; Fri, 7 Mar 2003 00:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261373AbTCGFs1>; Fri, 7 Mar 2003 00:48:27 -0500
Received: from msp-24-163-212-250.mn.rr.com ([24.163.212.250]:63872 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261369AbTCGFsX>; Fri, 7 Mar 2003 00:48:23 -0500
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
From: Shawn <core@enodev.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0303070649140.2662-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0303070649140.2662-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047016271.3640.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 06 Mar 2003 23:51:11 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 23:52, Ingo Molnar wrote:
> On Thu, 6 Mar 2003, Andrew Morton wrote:
> 
> > This improves the X interactivity tremendously.  I went back to 2.5.64
> > base just to verify, and the difference was very noticeable.
> > 
> > The test involved doing the big kernel compile while moving large xterm,
> > mozilla and sylpheed windows about.  With this patch the mouse cursor
> > was sometimes a little jerky (0.1 seconds, perhaps) and mozilla redraws
> > were maybe 0.5 seconds laggy.
> > 
> > So.  A big thumbs up on that one.  It appears to be approximately as
> > successful as sched-2.5.64-a5.

I'm sorry, I'm an idiot. Where's sched-2.5.64-a5 available for download?
Latest I found was  sched-2.5.63-B3 inside Andrew's patchset.

I'm kinda drooling over this thread.


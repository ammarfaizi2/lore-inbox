Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261373AbTCGFxu>; Fri, 7 Mar 2003 00:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261378AbTCGFxu>; Fri, 7 Mar 2003 00:53:50 -0500
Received: from mx1.elte.hu ([157.181.1.137]:28554 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261373AbTCGFxs>;
	Fri, 7 Mar 2003 00:53:48 -0500
Date: Fri, 7 Mar 2003 07:04:07 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Shawn <core@enodev.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <1047016495.3640.6.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303070703250.3107-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 6 Mar 2003, Shawn wrote:

> > so the correct approach is both to make X more interactive (your patch),
> > _and_ to make the compilation jobs less interactive (my patch). This is
> > that explains why Andrew saw roughly similar interactivity with you and my
> > patch applied separately, but the best result was when the combo patch was
> > applied. Agreed?
> 
> Even better, can you point me to where this "combo" patch can be found?

in the same thread, a few mails later, send by me. But better yet, try the
latest BK kernel, it has the 'combo' patch merged.

	Ingo


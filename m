Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281570AbRKPWCc>; Fri, 16 Nov 2001 17:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281586AbRKPWCN>; Fri, 16 Nov 2001 17:02:13 -0500
Received: from ns.suse.de ([213.95.15.193]:27411 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281580AbRKPWCI>;
	Fri, 16 Nov 2001 17:02:08 -0500
Date: Fri, 16 Nov 2001 23:02:03 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Dan Hollis <goemon@anime.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] AMD SMP capability sanity checking.
In-Reply-To: <Pine.LNX.4.30.0111161344020.5635-100000@anime.net>
Message-ID: <Pine.LNX.4.30.0111162256310.22827-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2001, Dan Hollis wrote:

> > Any "But my system is fine in SMP and isn't in the list" whinges won't
> > get it added to the list.
> Presumably you will add the same for intel chips (eg celerons).

As Intel never announced they were capable either, by rights they
should also get tainted imo. For now I'm working on getting the
Athlons sorted out though. There's enough different models of those
to keep me busy at the moment.

regards,
Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs


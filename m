Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267412AbTA1PVi>; Tue, 28 Jan 2003 10:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267413AbTA1PVh>; Tue, 28 Jan 2003 10:21:37 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:52233 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267412AbTA1PVh>; Tue, 28 Jan 2003 10:21:37 -0500
Date: Tue, 28 Jan 2003 10:27:30 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andre Hedrick <andre@linux-ide.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Update PnP IDE (2/6)
In-Reply-To: <Pine.LNX.4.10.10301272224420.9272-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.3.96.1030128102353.31898A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2003, Andre Hedrick wrote:

> 
> Bill,
> 
> Can you reproduce or validate my paranoia of the ever increasing channel
> index?

Unfortunately not until Friday. I only take one PCMCIA adaptor with me on
the road, so I can't try two until I get back to the office. I'll try
inserting two and removing the "first" one at that time. Any particular
kernel you think will or won't have this problem? It's easier to try on
2.4 unless you think it's a new 2.5 issue; My ISA/PCMCIA adaptor hasn't
been working with 2.5, I could update a laptop if needed.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288667AbSADPKJ>; Fri, 4 Jan 2002 10:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288666AbSADPKB>; Fri, 4 Jan 2002 10:10:01 -0500
Received: from mx2.elte.hu ([157.181.151.9]:58249 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288667AbSADPJs>;
	Fri, 4 Jan 2002 10:09:48 -0500
Date: Fri, 4 Jan 2002 18:07:15 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: dan kelley <dkelley@otec.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <Pine.LNX.4.33.0201040945430.9085-100000@nixon.bos.otec.net>
Message-ID: <Pine.LNX.4.33.0201041806400.9733-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Jan 2002, dan kelley wrote:

> using the 2.4.17 patch against a vanilla 2.4.17 tree, looks like there's a
> problem w/ reiserfs:

please check out the -A1 patch, this should be fixed.

	Ingo


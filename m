Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266609AbTBKWiF>; Tue, 11 Feb 2003 17:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266638AbTBKWiF>; Tue, 11 Feb 2003 17:38:05 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12559 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266609AbTBKWiE>; Tue, 11 Feb 2003 17:38:04 -0500
Date: Tue, 11 Feb 2003 14:44:19 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Steven Cole <elenstev@mesatop.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.60 problems with dbench and unkillable processes.
In-Reply-To: <1045003222.2570.497.camel@spc9.esa.lanl.gov>
Message-ID: <Pine.LNX.4.44.0302111443320.5321-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11 Feb 2003, Steven Cole wrote:
>
> With 2.5.60, dbench starts, prints "1 clients started", but never prints
> any "..." and doesn't finish.  

Yeah, it's fixed in the current BK tree, and I already posted a patch to 
linux-kernel for non-BK users. Sorry,

		Linus


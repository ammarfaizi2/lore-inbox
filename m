Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262823AbSJON6p>; Tue, 15 Oct 2002 09:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262824AbSJON6p>; Tue, 15 Oct 2002 09:58:45 -0400
Received: from mta03ps.bigpond.com ([144.135.25.135]:65006 "EHLO
	mta03ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S262823AbSJON6o> convert rfc822-to-8bit; Tue, 15 Oct 2002 09:58:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.20-pre10aa1 oops report (was Re: Linux-2.4.20-pre8-aa2 oops report. [solved])
Date: Wed, 16 Oct 2002 00:13:02 +1000
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <fd1cf102287.102287fd1cf@bigpond.com> <200210152305.32641.harisri@bigpond.com>
In-Reply-To: <200210152305.32641.harisri@bigpond.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210160013.02220.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> That precisely is the reason. The bad news is that system crashes when
> agpgart and radeon are compiled as modules, and the good news is that I am
> unable to crash it when they are not.

My goodness, I have spoken too early I guess. The -aa kernel crashes whether 
agpgart and radeon are modules or not.
 
> Mainline (2.4.20-pre10) is stable when agpgart and radeon are compiled as
> modules.

That holds true still.

> The problem is much easier to reproduce than I thought, just log in and log
> out of XFree86/Gnome few times (3 or more times in my case) is more than
> adequate to crash it.

That is still the case.
-- 
Hari
harisri@bigpond.com


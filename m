Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265711AbTBPCxg>; Sat, 15 Feb 2003 21:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265725AbTBPCxg>; Sat, 15 Feb 2003 21:53:36 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:40523
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265711AbTBPCxg>; Sat, 15 Feb 2003 21:53:36 -0500
Date: Sat, 15 Feb 2003 22:02:09 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: John Weber <weber@nyc.rr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5 freezing after uncompressing linux
In-Reply-To: <3E4EFD75.3000708@nyc.rr.com>
Message-ID: <Pine.LNX.4.50.0302152159290.16012-100000@montezuma.mastecende.com>
References: <3E4EFD75.3000708@nyc.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Feb 2003, John Weber wrote:

> [1.] One line summary of the problem:
> 
> [Linux 2.5] Freezing after Uncompressing Linux
> 
> [2.] Full description of the problem/report:
> 
> The kernel freezes immediately after "Uncompressing Linux... OK".
> No further messages are displayed.  I'm following wli's advice to
> add some printk's to check whether the system is even getting to
> startup_32(), but perhaps others have seen this problem.

Have you got early_printk? Hopefully you get to 32bit code

ftp://ftp.kernel.org/pub/linux/kernel/people/wli/early_printk/early_printk-2.5.54

-- 
function.linuxpower.ca

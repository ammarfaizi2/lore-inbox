Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbQKIGxh>; Thu, 9 Nov 2000 01:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129231AbQKIGx1>; Thu, 9 Nov 2000 01:53:27 -0500
Received: from saw.sw.com.sg ([203.120.9.98]:668 "HELO saw.sw.com.sg")
	by vger.kernel.org with SMTP id <S129057AbQKIGxI>;
	Thu, 9 Nov 2000 01:53:08 -0500
Message-ID: <20001109145301.A16021@saw.sw.com.sg>
Date: Thu, 9 Nov 2000 14:53:01 +0800
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: rmlynch@best.com, linux-kernel@vger.kernel.org
Subject: Re: Spew from test11-pre1
In-Reply-To: <3A09EC6F.C87A7729@best.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <3A09EC6F.C87A7729@best.com>; from "Robert Lynch" on Wed, Nov 08, 2000 at 04:14:39PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Nov 08, 2000 at 04:14:39PM -0800, Robert Lynch wrote:
> No oops, but right after I installed test11-pre1, then tried to
> access a Windows box as a VNC client, this message started
> getting continuously dumped by syslog:
> ===
> ...
> Nov  8 15:32:01 ives kernel: eth0: card reports no RX buffers.
> Nov  8 15:32:04 ives kernel: eth0: card reports no resources.
[snip]
> ===                  
> Doing a Yahoo search it seems this was previously reported
> eepro100 bug, which appears to have resurfaced.

It have never been finally fixed.
I'm working on a "next-generation workaround" right now.

Best regards
					Andrey V.
					Savochkin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288995AbSANUHY>; Mon, 14 Jan 2002 15:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288969AbSANUGS>; Mon, 14 Jan 2002 15:06:18 -0500
Received: from ns.ithnet.com ([217.64.64.10]:23048 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S289000AbSANUFh>;
	Mon, 14 Jan 2002 15:05:37 -0500
Date: Mon, 14 Jan 2002 21:05:15 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Jan-Hendrik Palic <jan.palic@linux-debian.de>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: 2.5.2-pre11 with sched01-H7 doesn't build
Message-Id: <20020114210515.6daf8c5a.skraw@ithnet.com>
In-Reply-To: <20020114194151.GA12487@billgotchy.de>
In-Reply-To: <20020114194151.GA12487@billgotchy.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002 20:41:52 +0100
Jan-Hendrik Palic <jan.palic@linux-debian.de> wrote:

> Hi .. 
> 
> I downloeded the linux-2.5.1.tar.bz2 and applied the patch for
> linux-2.5.2-pre11 patch and the sched01-H7 patch .. at building I got
> this : 
> sched.c:21: asm/sched.h: No such file or directory

Ah, I've seen this before... :-)

Did you update 2.5-patch, too, Ingo?

Regards,
Stephan



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319437AbSIGBaJ>; Fri, 6 Sep 2002 21:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319438AbSIGBaJ>; Fri, 6 Sep 2002 21:30:09 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:43278 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S319437AbSIGBaI>; Fri, 6 Sep 2002 21:30:08 -0400
Date: Sat, 7 Sep 2002 02:34:47 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH] 3/8 LTT for 2.5.33: Core trace statements
Message-ID: <20020907023447.A26319@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Karim Yaghmour <karim@opersys.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	LTT-Dev <ltt-dev@shafik.org>
References: <3D792935.DEE213D7@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D792935.DEE213D7@opersys.com>; from karim@opersys.com on Fri, Sep 06, 2002 at 06:16:21PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2002 at 06:16:21PM -0400, Karim Yaghmour wrote:
> 
> These are the core trace statements inserted by LTT. The files are modified:
> fs/buffer.c
> fs/exec.c
> fs/ioctl.c
> fs/open.c
> fs/read_write.c
> fs/select.c
> ipc/msg.c
> ipc/sem.c
> ipc/shm.c
> kernel/exit.c
> kernel/fork.c
> kernel/itimer.c
> kernel/sched.c
> kernel/signal.c
> kernel/softirq.c
> kernel/timer.c
> mm/filemap.c
> mm/memory.c
> mm/page_alloc.c
> mm/page_io.c
> net/core/dev.c
> net/socket.c


Umm, after LSM we get another bunch of totally undefined hooks??


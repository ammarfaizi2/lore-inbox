Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317355AbSFCKdm>; Mon, 3 Jun 2002 06:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317357AbSFCKdk>; Mon, 3 Jun 2002 06:33:40 -0400
Received: from codepoet.org ([166.70.14.212]:57831 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S317355AbSFCKd2>;
	Mon, 3 Jun 2002 06:33:28 -0400
Date: Mon, 3 Jun 2002 04:33:29 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Philippe Gerum <rpm@idealx.com>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
Message-ID: <20020603103328.GA16985@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Karim Yaghmour <karim@opersys.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Philippe Gerum <rpm@idealx.com>
In-Reply-To: <3CFB2A38.60242CBA@opersys.com> <20020603084606.GA15986@codepoet.org> <3CFB3378.5EB7420@opersys.com> <20020603095202.GA16392@codepoet.org> <3CFB40FB.E997F3E6@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk5, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jun 03, 2002 at 06:12:11AM -0400, Karim Yaghmour wrote:
> The problem here is the "quick glance" (no offense intended). The
> most important part of a patent is its claims. In the case of the

no offense taken.  I'm not a lawyer, so much beyond a quick
glance teaches me very little when reading such things.

> any such RTOS need not even know Linux is there. All it needs to
> know is that it has to call on adeos_suspend_domain() to go into
> a dormant state when it doesn't have any more "ready" tasks. In
> no way does it have a "Linux" task, as RTLinux and RTAI clearly
> do.

Thanks much for the explanation -- that was exactly what I 
was hoping to see.  Very very cool.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

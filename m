Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292554AbSCOOrM>; Fri, 15 Mar 2002 09:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292674AbSCOOqw>; Fri, 15 Mar 2002 09:46:52 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:15857 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S292554AbSCOOqn>; Fri, 15 Mar 2002 09:46:43 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020315144237.G24984@flint.arm.linux.org.uk> 
In-Reply-To: <20020315144237.G24984@flint.arm.linux.org.uk>  <20020315142854.E24984@flint.arm.linux.org.uk> <20020315131612.C24984@flint.arm.linux.org.uk> <30439.1016201464@redhat.com> <20020315142854.E24984@flint.arm.linux.org.uk> <1901.1016202759@redhat.com> 
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4 and 2.5: remove Alt-Sysrq-L 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 15 Mar 2002 14:46:42 +0000
Message-ID: <3147.1016203602@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


rmk@arm.linux.org.uk said:
>  I don't know of any Linux kernel that has ever been able to cope with
> PID1 dying.  I certainly remember facing the PID1 dying causing lockup
> as far back as 1.3 kernels, and I even tried to fix it back then.  The
> argument put forward for not fixing it is that PID1 should not exit.
> Period.

I distinctly recall it working perfectly OK in around 2.1.50. I had boxen 
where /sbin/init was a shell script which would bring up the interfaces,
enable routing, and exit.

--
dwmw2



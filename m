Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275320AbSIUAmC>; Fri, 20 Sep 2002 20:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275357AbSIUAmC>; Fri, 20 Sep 2002 20:42:02 -0400
Received: from p50887F27.dip.t-dialin.net ([80.136.127.39]:38590 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S275320AbSIUAmB>; Fri, 20 Sep 2002 20:42:01 -0400
Date: Fri, 20 Sep 2002 18:47:41 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Srinivas Chavva <chavvasrini@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Loading kernel
In-Reply-To: <20020920225506.13191.qmail@web13201.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0209201846520.342-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 20 Sep 2002, Srinivas Chavva wrote:
> "
> /etc/rc.sysinit: /var/log/dmesg: No such file or
> directory
> /etc/rc.sysinit: /var/log/ksyms.o: No such file or
> directory
> INIT: Entering run level:3
> Updating /etc/fstab execvp: No such file or directory
> 					[FAILED]
> Checking for new hardware
> /etc/rc3.d/S05Kudzu:/usr/sbin/kudzu: No such file or
> directory
> 					[FAILED]
> touch:creating '/var/lock/subsys/kudzu': No such file
> or directory
> "

That's really no kernel issue. The kernel seems to have booted fine, and 
I'd doubt that's fs corruption.

			Thunder
-- 
assert(typeof((fool)->next) == typeof(fool));	/* wrong */


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286262AbRLJNeH>; Mon, 10 Dec 2001 08:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286264AbRLJNd5>; Mon, 10 Dec 2001 08:33:57 -0500
Received: from mpdr0.detroit.mi.ameritech.net ([206.141.239.206]:39388 "EHLO
	mailhost.det.ameritech.net") by vger.kernel.org with ESMTP
	id <S286262AbRLJNdu>; Mon, 10 Dec 2001 08:33:50 -0500
Date: Mon, 10 Dec 2001 08:31:57 -0500 (EST)
From: volodya@mindspring.com
Reply-To: volodya@mindspring.com
To: Sarita N <sarita_navuluru@rediffmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: KERNEL SYSTEM CALLS DEFINITIONS
In-Reply-To: <20011209225143.30988.qmail@mailweb22.rediffmail.com>
Message-ID: <Pine.LNX.4.20.0112100830340.16932-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 9 Dec 2001, Sarita  N wrote:

> 
> Hello,
>          I am a grad student at the university of nebraska lincoln.
> I have to build a tool in C that would caputure the system calls and signals between a user application adn the operating system.  
> 
> I have started studying the Linux kernel.  Can I know how to go about it.  Where , in which Kernel file can I find the definitions of the various system calls - how have they been implemented in the kernel?
> 
> How do I go about the project?

a) look at strace
b) look at memtrace (probably simpler than strace to understand) 
   http://volodya-project.sf.net - memtrace is a part of
   "Preload" package.

                               Vladimir Dergachev

> 
> Thanks and regards,
> Sarita Navuluru. 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


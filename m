Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265568AbSKYTtt>; Mon, 25 Nov 2002 14:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265589AbSKYTtt>; Mon, 25 Nov 2002 14:49:49 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:2294 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S265568AbSKYTts>;
	Mon, 25 Nov 2002 14:49:48 -0500
Message-ID: <3DE28074.25F40711@mvista.com>
Date: Mon, 25 Nov 2002 11:56:36 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: arun4linux <arun4linux@indiatimes.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GUI based kernel Debugger
References: <200211242202.DAA10643@WS0005.indiatimes.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arun4linux wrote:
> 
> Hello,
> 
>   I need some info on GUI based kernel debuggers.
> 
>   I'd like to know whether any GUI based kernel debugger available? preferablly free ware one :-)
> 
>   Anybody tried cygwin on windows to debug linux target machine?

AFAIK you will be using gdb/ kgdb.  There are several (well
a couple, at least) GUI wrappers for gdb...  Haven't used
them myself, preferring the emacs wrapper.

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbTDHTac (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 15:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbTDHTac (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 15:30:32 -0400
Received: from f20.pav2.hotmail.com ([64.4.37.20]:57862 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S261631AbTDHTab (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 15:30:31 -0400
X-Originating-IP: [129.219.25.77]
X-Originating-Email: [bhushan_vadulas@hotmail.com]
From: "shesha bhushan" <bhushan_vadulas@hotmail.com>
To: rddunlap@osdl.org
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: KERNEL PROFILING
Date: Tue, 08 Apr 2003 19:42:03 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F20Lig41UjdSkleUBUh0001d797@hotmail.com>
X-OriginalArrivalTime: 08 Apr 2003 19:42:03.0896 (UTC) FILETIME=[EE2CAF80:01C2FE06]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi
If I use the command line option "profile=2" while booting the system, why 
/proc/profile file is not created? Should I have to create it manually?

Thanking You'
Shesha





>From: "Randy.Dunlap" <rddunlap@osdl.org>
>To: "shesha bhushan" <bhushan_vadulas@hotmail.com>
>CC: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
>Subject: Re: KERNEL PROFILING
>Date: Tue, 8 Apr 2003 08:01:55 -0700
>
>On Tue, 08 Apr 2003 07:58:54 +0000 "shesha bhushan" 
><bhushan_vadulas@hotmail.com> wrote:
>
>| HI ALL,
>|   I am trying to profile the linux kernel. Can any one suggest an easy 
>way
>| to do. Like, I wanted to see how much TCP is using CPU, how much of CPU 
>is
>| used in memcpy, etc.
>| Can any one please suggest me.
>
>Start with the file linux/Documentation/basic_profiling.txt
>(it's in Linux 2.5.66-or-so or later).
>
>It explains how to use oprofile and readprofile.
>
>You can read about oprofile at http://oprofile.sourceforge.net/ .
>
>You can read about basic in-kernel profiling using /proc/profile
>and readprofile via 'man readprofile'.  It's simple to use.
>
>--
>~Randy


_________________________________________________________________
Say it now. Say it online. http://www.msn.co.in/ecards/ Send e-cards to your 
love


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319631AbSIMM5g>; Fri, 13 Sep 2002 08:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319634AbSIMM5g>; Fri, 13 Sep 2002 08:57:36 -0400
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:31906 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S319631AbSIMM5f> convert rfc822-to-8bit; Fri, 13 Sep 2002 08:57:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Vishal <vishal@naturesoft.net>, linux-kernel@vger.kernel.org
Subject: Re: building a very basic minimal LINUX.
Date: Fri, 13 Sep 2002 08:01:33 -0500
User-Agent: KMail/1.4.1
References: <1031904489.2888.138.camel@vishal.naturesoft.com>
In-Reply-To: <1031904489.2888.138.camel@vishal.naturesoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209130801.33326.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 September 2002 03:08 am, Vishal wrote:
> Hi all,
>   i want to start work on building a base linux system(i386 machine,32MB
> flash,with networking support) to be installed on flash for an embedded
> system. Can anyone direct me to any information\docs\ideas for starting
> off with such work?.
>   Thanks in advance.
> regards,
> Vishal

Check the router project. I think the foundation you want is there
in that all the utilities for network support (plus a few more for
maintenance) is already done.

You may want to add some interpreters (perl, python,tcl/tk) or
whatever embeded application you have, but that would make
for a fairly usable system.
-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

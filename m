Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTDLPMz (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 11:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbTDLPMz (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 11:12:55 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:56761 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP id S263298AbTDLPMy (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 11:12:54 -0400
Message-ID: <3E983288.9000000@kegel.com>
Date: Sat, 12 Apr 2003 08:36:40 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       crossgcc@sources.redhat.com
Subject: Re: gcc-2.95 broken on PPC?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A high white horse souse wrote:
 > I wouldn't switch to gcc-3.3 for now, the gcc mailing list looks like it
 > has more problems and less features than the unstable bleeding edge
 > gcc-3.4 CVS version.  I am using gcc 3.2.2 for everything.  I compiled
 > my X, my libc, my kernel, my KDE.  That is the first 3.x version that
 > didn't produce incorrect code for any of these.

Thanks for the info.  I feel a lot better about trying gcc-3.2.2 now.
Does anyone know if it needs patches to produce a working kernel
and glibc on sh4?  gcc-3.0.4 needed a sizable patch on sh4, I seem to recall,
but not on ppc.

 > The down side is that creating cross compilers from gcc 3.x is a lot
 > harder unless you already have a cross compiled glibc from gcc 2.95.x
 > in the proper paths.

Yep.  I'm not looking forward to dealing with that.  Shame the gcc
team keeps making building cross compilers harder.
- Dan

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291659AbSBAJ76>; Fri, 1 Feb 2002 04:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291660AbSBAJ7t>; Fri, 1 Feb 2002 04:59:49 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:57751 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S291659AbSBAJ7l>; Fri, 1 Feb 2002 04:59:41 -0500
Message-Id: <200202010959.g119xXH3008047@tigger.cs.uni-dortmund.de>
To: Greg Boyce <gboyce@rakis.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Machines misreporting Bogomips 
In-Reply-To: Message from Greg Boyce <gboyce@rakis.net> 
   of "Thu, 31 Jan 2002 17:55:57 EST." <Pine.LNX.4.42.0201311747560.24180-100000@egg> 
Date: Fri, 01 Feb 2002 10:59:32 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Boyce <gboyce@rakis.net> said:

[...]

> Every once in a while we come across single machines which are running a
> lot slower than they should be, and are misreporting their speed in
> bogomips under /proc/cpuinfo.  Reinstalling the OS and changing versions
> of the kernel don't appear to affect the machines themselves at all.

Just misrepresented bogomips or is the machine really slower? Perhaps the
CPU is being underclocked?
-- 
Horst von Brand			     http://counter.li.org # 22616

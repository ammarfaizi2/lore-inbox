Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281560AbRKWPBG>; Fri, 23 Nov 2001 10:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282164AbRKWPA5>; Fri, 23 Nov 2001 10:00:57 -0500
Received: from [213.235.52.105] ([213.235.52.105]:15766 "EHLO
	morpheus.streamgroup.co.uk") by vger.kernel.org with ESMTP
	id <S281560AbRKWPAr>; Fri, 23 Nov 2001 10:00:47 -0500
Date: Fri, 23 Nov 2001 14:59:24 +0000 (GMT)
From: <lk@morpheus.streamgroup.co.uk>
To: <linux-kernel@vger.kernel.org>
Subject: Development
Message-ID: <Pine.LNX.4.33.0111231446220.2715-100000@morpheus.streamgroup.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Ok, pre-email warning : this might get some people annoyed.
However, I do not mean to troll or start flamewars. Please,
bear with me.

I grow increasingly worried about the speed that the kernel
development is going at. No, I'm not saying "get things done
faster! I want more features! Support my usb joystick now!!"
I'm worried by the amount of drivers that are included in a
stable kernel release that are not marked "Experimental" and
yet are broken, as well as major compile problems in stable
releases.

Things such as show_trace_task() in only the i386 tree,
the Xircom net drivers freezing, APM broken on VIA chipsets
(and my dell inspiron 8100) - this should be working in a
stable release.

I'm worried that we're pushing things too fast and not taking
the time to test. The famous broken loopback in 2.4.14 and
the nasty symlink bug in 2.4.11 come to mind.

Perhaps we need to take a little more time before stamping
things as "stable"? Otherwise our beloved Linux might go
the way of Windows - "use at your own risk". I'd really
hate to see that.

Thanks,

MikeH


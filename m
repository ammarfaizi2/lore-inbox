Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264275AbUDTWKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbUDTWKA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 18:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264279AbUDTWJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 18:09:50 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:43269 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S264275AbUDTToZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 15:44:25 -0400
Message-ID: <40857E19.7000009@techsource.com>
Date: Tue, 20 Apr 2004 15:46:33 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Joel Jaeggli <joelja@darkwing.uoregon.edu>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: System hang with ATI's lousy driver
References: <Pine.LNX.4.44.0404201216280.10469-100000@twin.uoregon.edu>
In-Reply-To: <Pine.LNX.4.44.0404201216280.10469-100000@twin.uoregon.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for responding.

Joel Jaeggli wrote:

> 
> kernel drm + xfree86 driver will actually provide accelerated opengl 
> support in Xwindows albiet without quite as many hardware features as the 
> proprietary driver on all the rv2xx chipsets including the 9000 but not 
> on the later models. 

Well, maybe I should go back and try to get Mesa to work.  I don't need 
a lot of acceleration.  It's just that when I was using the Mesa driver, 
the OpenGL rendering would flash wildly, the colors would be all wrong, 
and the Z buffering was totally messed up, messing up the layering of 
objects, etc.  I didn't have this problem with RH9, but with Gentoo, 
it's completely broken.  Of course, I probably flubbed a step in the 
installation (that seems to be a 'feature' of Gentoo, although I really 
like Gentoo).

> 
> kernel drm & radeonfb have been reported to not play very well with each 
> other in other venues. vesafb is known to work in this situation though.

Maybe that's what I should use.  The 2.6 radeonfb doesn't seem to 
accelerate scrolling right yet anyhow, so what do I care?  :)


THANKS!


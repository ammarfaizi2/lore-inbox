Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268111AbTB1T4y>; Fri, 28 Feb 2003 14:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268112AbTB1T4y>; Fri, 28 Feb 2003 14:56:54 -0500
Received: from adsl-63-195-13-67.dsl.chic01.pacbell.net ([63.195.13.67]:39433
	"EHLO mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id <S268111AbTB1T4x>; Fri, 28 Feb 2003 14:56:53 -0500
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: linux-kernel@vger.kernel.org
Date: Fri, 28 Feb 2003 12:07:06 -0800
MIME-Version: 1.0
Subject: Kernel 2.5 input layer info?
Message-ID: <3E5F50EA.13587.3FA4953@localhost>
In-reply-to: <1786144585.20030228074127@wlink.com.np>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guys,

I have heard about the new 2.5 input layer work that is being done in the 
kernel, and I am interested in using this for a userland mouse/keyboard 
daemon I am looking at building. The intention of the daemon is to 
provide a common interface for event driven mouse and keyboard 
applications (ie: XFree86, Qt/E, SDL, MGL, SVGALib etc) on Linux. Since 
it appears that a lot of work is already being done on a new set of event 
driven input layers in the kernel, what I would like to do is build this 
daemon such that it will use the new 2.5 kernel interfaces when they are 
available, but fall back on the old compatible methods when not. 
Essentially I am planning on taking the existing XFree86 code and using 
it to make a common user land input daemon.

Anyway, let me know if you think this is a good idea, bad idea or if 
there is a better way to do it. The new input interfaces sound like a 
great idea, but we are looking for something that will work on as many 
versions of Linux as possible.

Finally where can I find more information on the new input interfaces in 
the 2.5 kernel? I just downloaded the latest 2.5.63 release and will take 
a look at it, but if there are any external docs on this I would like to 
peruse them first.

Thanks!

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~


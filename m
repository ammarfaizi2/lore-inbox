Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262731AbTC0ArR>; Wed, 26 Mar 2003 19:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262733AbTC0ArR>; Wed, 26 Mar 2003 19:47:17 -0500
Received: from nmh.informatik.uni-bremen.de ([134.102.224.3]:52711 "EHLO
	nmh.informatik.uni-bremen.de") by vger.kernel.org with ESMTP
	id <S262731AbTC0ArQ>; Wed, 26 Mar 2003 19:47:16 -0500
To: linux-kernel@vger.kernel.org
From: Moritz Muehlenhoff <jmm@Informatik.Uni-Bremen.DE>
Subject: Re: sisfb: two more little problems
In-Reply-To: <Pine.LNX.4.44.0303270021000.25001-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0303270021000.25001-100000@phoenix.infradead.org>
Date: Thu, 27 Mar 2003 01:58:23 +0100
Message-Id: <E18yLip-0000ae-00@regenbogen.informatik.uni-bremen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
>> 2. I can't seem to set the default video mode from the kernel command
>> line.  I have tried:
>> 
>> video=sis:1024x768-24@75
>> video=sisfb:1024x768-24@75
>> 
>> and neither one works.  What is the expected command line?
> 
> It is video=sisfb:...
> 
> Hm. It should work. 

The sisfb parameter syntax is a bit tricky, it's explained at the
maintainer's website:

http://www.webit.at/~twinny/linuxsisvga.shtml

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267166AbSLEA4n>; Wed, 4 Dec 2002 19:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267170AbSLEA4n>; Wed, 4 Dec 2002 19:56:43 -0500
Received: from h-64-105-35-8.SNVACAID.covad.net ([64.105.35.8]:60039 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267166AbSLEA4n>; Wed, 4 Dec 2002 19:56:43 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 4 Dec 2002 17:02:49 -0800
Message-Id: <200212050102.RAA03231@adam.yggdrasil.com>
To: andrew@erlenstar.demon.co.uk
Subject: Re: bincancels in linux.kernel
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Gierth wrote:
>the only reason I do it at all is because the alternative is to do
>nothing and watch the problem get worse.

	At this time, it sounds like the existing spam countermeasures
on the lkml mailing list work well enough that your bincancels were
doing more harm than good.  That could change in future.  At that
point, I suspect that the bincanelling would be done at the mailing
list.  So, I'd say leave bincanceling of linux.kernel off and that'll
be the end of this issue (at least until someone specifically requests
otherwise).

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

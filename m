Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263943AbTDWDTk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 23:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263944AbTDWDTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 23:19:40 -0400
Received: from ca-fulrtn-cuda2-c6a-113.anhmca.adelphia.net ([68.66.9.113]:15775
	"EHLO shrike.mirai.cx") by vger.kernel.org with ESMTP
	id S263943AbTDWDTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 23:19:39 -0400
Message-ID: <3EA60920.8090800@tmsusa.com>
Date: Tue, 22 Apr 2003 20:31:44 -0700
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael B Allen <mba2000@ioplex.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: What's the deal McNeil? Bad interactive behavior in X w/ RH's
      2.4.18
References: <20030422034821.6a57acc0.mba2000@ioplex.com>      <200304221006.09601.m.c.p@wolk-project.de> <38291.207.172.171.44.1051004102.squirrel@miallen.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael B Allen wrote:

>Ok, I searched a little using the Googler at indiana.edu's archives but
>nothing jumped up and bit me. I'm not too excited about applying a patch
>snarfed out of an e-mail anywat. I'm surprised no one else has not
>complained about this enough to the point where you guys don't have a
>canned answer with a link. Is this problem not considered important?
>
Yes, the link is www.redhat.com/errata

But yes, for those who like to roll their
own, Con's responsiveness patchset is
farily well regarded and trusted - you
can grab it from kernel.kolivas.org -

I've had good results with just the 001,
002 and 003 patches on stock 2.4.20 -

>
>Does anyone know which RH patch in the 2.4.18-10 RPM adds this elevator
>throughput "improvement"? What identifiers would such a patch have in it?
>  
>
2.4.18-10?

You want 2.4.18-27.7x - in other words, the
current redhat kernel for your release.

The patches are all in the kernel srpm for
you to view and analyze...

BTW If you really want low latency you'll
love 2.6

Joe


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264791AbSJVRUZ>; Tue, 22 Oct 2002 13:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264792AbSJVRUZ>; Tue, 22 Oct 2002 13:20:25 -0400
Received: from kathmandu.sun.com ([192.18.98.36]:9179 "EHLO kathmandu.sun.com")
	by vger.kernel.org with ESMTP id <S264791AbSJVRUX>;
	Tue, 22 Oct 2002 13:20:23 -0400
Message-ID: <3DB58A47.4020404@sun.com>
Date: Tue, 22 Oct 2002 10:26:31 -0700
From: Tim Hockin <thockin@sun.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 1/4] fix NGROUPS hard limit (resend)
References: <200210220036.g9M0aP831358@scl2.sfbay.sun.com> <1035280294.31917.19.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ok sanity check time. Why do you need qsort and bsearch for this kind of
> thing. Just how many groups do you plan to support ?

Unlimited - we've tested with tens of thousands.



-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Linux Kernel Engineering
thockin@sun.com


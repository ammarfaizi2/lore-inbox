Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266456AbSKUJF4>; Thu, 21 Nov 2002 04:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266460AbSKUJF4>; Thu, 21 Nov 2002 04:05:56 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:34900 "EHLO xsmtp.ethz.ch")
	by vger.kernel.org with ESMTP id <S266456AbSKUJFz>;
	Thu, 21 Nov 2002 04:05:55 -0500
Message-ID: <3DDCA39C.7040602@debian.org>
Date: Thu, 21 Nov 2002 10:13:00 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en, it-ch, it, fr
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: TAINTED (Re: spinlocks, the GPL, and binary-only modules)
References: <fa.ng6tk8v.6nq3q2@ifi.uio.no> <fa.ni4rlmv.3gc2ob@ifi.uio.no>
In-Reply-To: <fa.ng6tk8v.6nq3q2@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Nov 2002 09:13:02.0019 (UTC) FILETIME=[3141C930:01C2913E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If Linux is to truly only a GPL binary module friendly environment, then
> it must enforce the rules.  Therefore it must forcablely reject the
> attempt to load any and all binaries which are not GPL.  Regardless if the
> license is commerial yet the source code is available.
> 

Read GPL!
I can modify/create *private* and completly *non-free* code, and link to GPL,
legally. [I cannot distribute it, but kernel should not block me!]
  nvidia unfortunatly use this, to not to disclose the complete sources]
And I can use an other OSI approved license, GPL compatible,
but if it is not yet recognized by kernel? Should kernel include all free
licences strings?

ciao
	giacomo


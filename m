Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263991AbTAPHEc>; Thu, 16 Jan 2003 02:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbTAPHEc>; Thu, 16 Jan 2003 02:04:32 -0500
Received: from fmr01.intel.com ([192.55.52.18]:32238 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S263991AbTAPHEb>;
	Thu, 16 Jan 2003 02:04:31 -0500
Subject: Re: [BUG][2.5]deadlock on cpci hot insert
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Scott Murray <scottm@somanetworks.com>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pcihpd-discuss <pcihpd-discuss@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0301160014250.20085-100000@rancor.yyz.somanetworks.com>
References: <Pine.LNX.4.44.0301160014250.20085-100000@rancor.yyz.somanetworks.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 15 Jan 2003 23:04:48 -0800
Message-Id: <1042700689.1153.15.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-15 at 21:33, Scott Murray wrote:
> PS: Any word on whether my ZT5550 driver patch from last Friday fixes
>     your ZT5084 chassis issues?

Oh yea, that's the other thing I was going to do.  I just built and
installed the patched kernel with no problems, but I will be able to say
more after I have physical access to my lab tomorrow.

    --rustyl


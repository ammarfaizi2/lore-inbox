Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268744AbTBZNgl>; Wed, 26 Feb 2003 08:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268745AbTBZNgl>; Wed, 26 Feb 2003 08:36:41 -0500
Received: from almesberger.net ([63.105.73.239]:10259 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S268744AbTBZNgk>; Wed, 26 Feb 2003 08:36:40 -0500
Date: Wed, 26 Feb 2003 10:45:24 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, torvalds@transmeta.com,
       rth@twiddle.net, linux-kernel@vger.kernel.org,
       kai@tp1.ruhr-uni-bochum.de,
       "Milton D. Miller II" <miltonm@realtime.net>
Subject: Re: [PATCH] eliminate warnings in generated module files
Message-ID: <20030226104523.L2791@almesberger.net>
References: <1707.4.64.238.61.1046230558.squirrel@www.osdl.org> <20030226041359.C92F52C05D@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030226041359.C92F52C05D@lists.samba.org>; from rusty@rustcorp.com.au on Wed, Feb 26, 2003 at 03:08:26PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> OTOH, __optional is fairly clearly "you can drop it".  "Unused" is
> clearly a lie for some configurations.

__maybe_unused ? :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/

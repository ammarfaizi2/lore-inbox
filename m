Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTDHWlh (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 18:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbTDHWlh (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 18:41:37 -0400
Received: from almesberger.net ([63.105.73.239]:522 "EHLO host.almesberger.net")
	by vger.kernel.org with ESMTP id S262196AbTDHWlf (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 18:41:35 -0400
Date: Tue, 8 Apr 2003 19:53:05 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 64-bit kdev_t - just for playing
Message-ID: <20030408195305.F19288@almesberger.net>
References: <200303311541.50200.pbadari@us.ibm.com> <Pine.LNX.4.44.0304031256550.5042-100000@serv> <20030403133725.GA14027@win.tue.nl> <Pine.LNX.4.44.0304031548090.12110-100000@serv> <b6s3tm$i2d$1@cesium.transmeta.com> <Pine.LNX.4.44.0304071742490.12110-100000@serv> <Pine.LNX.4.44.0304072351110.12110-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304072351110.12110-100000@serv>; from zippel@linux-m68k.org on Mon, Apr 07, 2003 at 11:57:56PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Date:   Mon, 7 Apr 2003 22:10:11 +0200 (CEST)
[...]
> Date: 	Mon, 7 Apr 2003 23:57:56 +0200 (CEST)
[...]
> Ok, Peter refuses to give me an answer to that,

That was a quick conclusion, after less than two hours :-)

Anyway, I agree with your general concern. It only seems good
engineering practice to also look at the numbering schemes that
are supposed to go with the device number enlargement.

Or, alternatively, to make sure that it's trivial to make further
enlargements (or shrinkages), if the need for them should arise.
I didn't look at the issue in detail, but perhaps the latter is
the case ?

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131974AbQKXGlQ>; Fri, 24 Nov 2000 01:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131987AbQKXGlG>; Fri, 24 Nov 2000 01:41:06 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:58378 "EHLO
        wire.cadcamlab.org") by vger.kernel.org with ESMTP
        id <S131974AbQKXGkz>; Fri, 24 Nov 2000 01:40:55 -0500
Date: Fri, 24 Nov 2000 00:10:51 -0600
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gcc 2.95.2 is buggy
Message-ID: <20001124001051.D8881@wire.cadcamlab.org>
In-Reply-To: <UTC200011240157.CAA140709.aeb@aak.cwi.nl> <20001124171014.A26050@metastasis.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001124171014.A26050@metastasis.f00f.org>; from cw@f00f.org on Fri, Nov 24, 2000 at 05:10:14PM +1300
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Chris Wedgwood]
> taking away -O2 is a 'fix' for now... not a very good one though.

Not if you want function inlining to work.  The kernel *won't compile*
without optimization.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

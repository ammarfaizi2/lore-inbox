Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131182AbRAKEQS>; Wed, 10 Jan 2001 23:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131330AbRAKEQH>; Wed, 10 Jan 2001 23:16:07 -0500
Received: from marine.sonic.net ([208.201.224.37]:10352 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S131182AbRAKEP5>;
	Wed, 10 Jan 2001 23:15:57 -0500
X-envelope-info: <dhinds@sonic.net>
Message-ID: <20010110201537.F12593@sonic.net>
Date: Wed, 10 Jan 2001 20:15:37 -0800
From: David Hinds <dhinds@sonic.net>
To: Miles Lane <miles@megapathdsl.net>,
        Aaron Eppert <eppertan@rose-hulman.edu>
Cc: dhinds@zen.stanford.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 Patch for 3c575
In-Reply-To: <20010110204420.A7699@rose-hulman.edu> <3A5D20D6.6090906@megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3A5D20D6.6090906@megapathdsl.net>; from Miles Lane on Wed, Jan 10, 2001 at 06:56:22PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 06:56:22PM -0800, Miles Lane wrote:
> 
> There's one other annoyance:
> 
> The config files for pcmcia-cs expect the 3c575_cb driver,
> so I either have to hack the configuration files or load
> the 3c59x driver by hand.

Yes, I'm not sure how to best communicate the fact that 3c59x should
be used to cardmgr.

-- Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

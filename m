Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267615AbTALWqo>; Sun, 12 Jan 2003 17:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267610AbTALWqD>; Sun, 12 Jan 2003 17:46:03 -0500
Received: from mta1.srv.hcvlny.cv.net ([167.206.5.4]:35724 "EHLO
	mta1.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S267612AbTALWpE>; Sun, 12 Jan 2003 17:45:04 -0500
Date: Sun, 12 Jan 2003 17:51:57 -0500
From: Rob Wilkens <robw@optonline.net>
Subject: Re: any chance of 2.6.0-test*?
In-reply-to: <200301122343.41150.oliver@neukum.name>
To: Oliver Neukum <oliver@neukum.name>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: robw@optonline.net
Message-id: <1042411916.1209.181.camel@RobsPC.RobertWilkens.com>
Organization: Robert Wilkens
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com>
 <200301122306.14411.oliver@neukum.name>
 <1042410145.3162.152.camel@RobsPC.RobertWilkens.com>
 <200301122343.41150.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 17:43, Oliver Neukum wrote:
> It's code that causes added hardship for anybody checking the locking.

I can certainly see where it would seem "easier" to match "one lock" to
"one unlock" if your troubleshooting a locking issue.

"easier" is the motivation behind using goto.. Laziness.. that's all it
is.

-Rob


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263208AbTCTElB>; Wed, 19 Mar 2003 23:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263209AbTCTElB>; Wed, 19 Mar 2003 23:41:01 -0500
Received: from imap.gmx.net ([213.165.65.60]:63249 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S263208AbTCTElA>;
	Wed, 19 Mar 2003 23:41:00 -0500
Message-Id: <5.2.0.9.2.20030320055216.01f8be00@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Thu, 20 Mar 2003 05:56:30 +0100
To: Charles Baylis <cb-lkml@fish.zetnet.co.uk>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.5.65-mm2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200303192317.22103.cb-lkml@fish.zetnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:17 PM 3/19/2003 +0000, Charles Baylis wrote:

>I'm getting quite a lot of audio skips with this one. 2.5.64-mm8 was the
>last one I tested and it was very good.
>
>2.5.64-mm8 works fine with pretty much any thud load I throw at it, but thud
>3 is enough to cause some skips with 2.5.65-mm2. Thud 5 causes serious
>starvation problems to the whole desktop.

My crude hack helped with thud and some others, but is b0rken for others.

         -Mike  


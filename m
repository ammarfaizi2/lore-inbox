Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276707AbRKFBMa>; Mon, 5 Nov 2001 20:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276665AbRKFBMU>; Mon, 5 Nov 2001 20:12:20 -0500
Received: from fluent1.pyramid.net ([206.100.220.212]:13870 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S276832AbRKFBMB>; Mon, 5 Nov 2001 20:12:01 -0500
Message-Id: <4.3.2.7.2.20011105171103.00be99d0@10.1.1.42>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 05 Nov 2001 17:11:47 -0800
To: Daniel Phillips <phillips@bonn-fries.net>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>
From: Stephen Satchell <satch@concentric.net>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011106005304Z17249-18972+252@humbolt.nl.linux.org>
In-Reply-To: <200111052246.fA5MkxG288247@saturn.cs.uml.edu>
 <200111052246.fA5MkxG288247@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:54 AM 11/6/01 +0100, Daniel Phillips wrote:
>Lets just not lose sight of the overhead connected with ASCII proc IO, it's a
>lot more than some seem to think.

Any idea what the overhead connected with a binary proc IO would be?  From 
looking at some of the code, it would appear that you have a lot of 
overhead no matter what you do.

Satch


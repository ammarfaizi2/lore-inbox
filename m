Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWEZIvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWEZIvd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 04:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWEZIvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 04:51:33 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:2970 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751184AbWEZIvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 04:51:33 -0400
Date: Fri, 26 May 2006 10:51:19 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Helge Hafting <helge.hafting@aitel.hist.no>
cc: Nathan Scott <nathans@sgi.com>, linux-xfs@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: XFS write speed drop
In-Reply-To: <4476AC3B.5030704@aitel.hist.no>
Message-ID: <Pine.LNX.4.61.0605261047440.16828@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0605190047430.23455@yvahk01.tjqt.qr>
 <20060522105326.A212600@wobbly.melbourne.sgi.com>
 <Pine.LNX.4.61.0605221308290.11108@yvahk01.tjqt.qr>
 <20060523084309.A239136@wobbly.melbourne.sgi.com>
 <Pine.LNX.4.61.0605231517330.25086@yvahk01.tjqt.qr> <4476AC3B.5030704@aitel.hist.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Well as mentioned, -o nobarrier solved it, and that's it. I do not
>> actually need barriers (or an UPS, to poke on another thread), because
>> power failures are rather rare in Germany.
>
> Then there are mistakes like someone stepping on the power
> cord, pulling out the wrong one, drilling holes in the wall,
> there are kernel crashes, there is lightning,
> there is the possibility that some
> component inside the box just breaks.
>
A mathematician has fear of flying because there could possibly be a 
terrorist bomb inside the plane. What does he do?
Taking an bomb with himself, because the probablity that there are two 
bombs inside a plane is lower than one.

What I am wanting to say is that the factors you mentioned just do not happen
here, at this one - home - box.


Jan Engelhardt
-- 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264610AbSJWKOx>; Wed, 23 Oct 2002 06:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264611AbSJWKOx>; Wed, 23 Oct 2002 06:14:53 -0400
Received: from [213.38.169.194] ([213.38.169.194]:8460 "EHLO
	proxy.herefordshire.gov.uk") by vger.kernel.org with ESMTP
	id <S264610AbSJWKOv>; Wed, 23 Oct 2002 06:14:51 -0400
Message-ID: <0EBC45FCABFC95428EBFC3A51B368C9501AFB3@jessica.herefordshire.gov.uk>
From: "Randal, Phil" <prandal@herefordshire.gov.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [BK PATCH 1/4] fix NGROUPS hard limit (resend)
Date: Wed, 23 Oct 2002 11:16:45 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Peter Chubb [mailto:peter@chubb.wattle.id.au]
> Sent: 23 October 2002 01:09
> To: Jesse Pollard
> Cc: Tim Hockin; Linux Kernel Mailing List
> Subject: Re: [BK PATCH 1/4] fix NGROUPS hard limit (resend)
> 
> 
> >>>>> "Jesse" == Jesse Pollard <pollard@admin.navo.hpc.mil> writes:
> 
> Jesse> On Tuesday 22 October 2002 12:37 pm, Tim Hockin wrote:
> 
> Jesse> And I really doubt that anybody has 10000 unique groups (or
> Jesse> even close to that) running under any system. The center I'm at
> 
> well... if you put each user in his or her own group, the total number
> of unique groups gets pretty big pretty fast.  
> 
> That doesn't mean, however, that one needs to be in thousands of
> groups simultaneously.
> 
> Peter C

IIRC, the RedHat distro tries to put each new user in their own
group by default.

Phil

---------------------------------------------
Phil Randal
Network Engineer
Herefordshire Council
Hereford, UK

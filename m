Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283272AbRLWDBW>; Sat, 22 Dec 2001 22:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283287AbRLWDBO>; Sat, 22 Dec 2001 22:01:14 -0500
Received: from embolism.psychosis.com ([216.242.103.100]:37893 "EHLO
	embolism.psychosis.com") by vger.kernel.org with ESMTP
	id <S283272AbRLWDBC>; Sat, 22 Dec 2001 22:01:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: Booting a modular kernel through a multiple streams file
Date: Sat, 22 Dec 2001 22:00:56 -0500
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0112222109050.21702-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0112222109050.21702-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Hysa-0002kc-00@schizo.psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 December 2001 21:10, Alexander Viro wrote:

> > cpio is trivial.  tar is a bit more painful, but not too bad.  gzip is
> > unacceptable, but should not be required.
>
> tar is ugly as hell and not going to be supported on the kernel side.

Excellent! You've settled on using using an archiver format nobody uses,
instead of the defacto standard that's already been implemented by
atleast two people.
			G-E-N-I-U-S!

>IIRC, his objections back then were about linking archive into the kernel
>image.  s/disaster/ugly stuff that was nowhere near top-priority and got 
>fixed since then/ and I agree with that one.

Ahh good. Maybe you'll wise up to supporting tar as well. Then in
maybe a year and a half from now standard Linux will finally have
what I've had in production for 3 years...

Dave

-- 
The time is now 22:54 (Totalitarian)  -  http://www.ccops.org/

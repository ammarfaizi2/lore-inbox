Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282204AbRKWS3G>; Fri, 23 Nov 2001 13:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282201AbRKWS25>; Fri, 23 Nov 2001 13:28:57 -0500
Received: from dsl-213-023-043-128.arcor-ip.net ([213.23.43.128]:15119 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S282200AbRKWS2l>;
	Fri, 23 Nov 2001 13:28:41 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Anton Altaparmakov <aia21@cam.ac.uk>, war <war@starband.net>
Subject: Re: Which gcc version?
Date: Fri, 23 Nov 2001 19:30:27 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20011123125137Z282133-17408+17815@vger.kernel.org> <5.1.0.14.2.20011123135801.00aad970@pop.cus.cam.ac.uk>
In-Reply-To: <5.1.0.14.2.20011123135801.00aad970@pop.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E167L5w-0002Oi-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 23, 2001 02:59 pm, Anton Altaparmakov wrote:
> At 13:51 23/11/01, war wrote:
> >You should use gcc-2.95.3.
> 
> That's not true. gcc-2.96 as provided with RedHat 7.2 is perfectly fine.
> 
> gcc-3x OTOH is not a good idea at the moment.

Do you have any particular reason for saying that?

Just for the record, I've been building kernels exclusively with 3.0x 
(currently 3.02) for more than a month without problems.  At some point you 
just have to take a deep breath and take the plunge ;-)

I agree that it's a good idea for comercial distributions, large corporations 
and to like, to be as a year or two behind the compiler curve, but for a 
kernel developer or unstable kernel addict to be paranoid about gcc 3.0 is in 
my mind, just plain silly.  If you are building the latest kernel you might 
as well build it with the latest compiler, the risks are roughly the same.

Through widespread use, whatever wrinkles still remain in gcc3 will be ironed 
out.  In fact, I'd say it's something of a moral responsibility to adopt the 
new compiler sooner, rather than later.  It helps make our tool chain 
stronger.

--
Daniel

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282221AbRKWUQB>; Fri, 23 Nov 2001 15:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282220AbRKWUPv>; Fri, 23 Nov 2001 15:15:51 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:2833 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S282322AbRKWUPs>; Fri, 23 Nov 2001 15:15:48 -0500
Message-ID: <3BFEAE22.1CE8DE5B@zip.com.au>
Date: Fri, 23 Nov 2001 12:14:26 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Anton Altaparmakov <aia21@cam.ac.uk>, war <war@starband.net>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: Which gcc version?
In-Reply-To: <5.1.0.14.2.20011123135801.00aad970@pop.cus.cam.ac.uk> <5.1.0.14.2.20011123185333.00afd920@pop.cus.cam.ac.uk>,
		<5.1.0.14.2.20011123185333.00afd920@pop.cus.cam.ac.uk> <E167M0I-0002PD-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> If there is a performance hit, it's not enough to worry about.

except egcs-1.1.2 (2.91.6) compiles stuff at almost twice the speed
of gcc3.  The person who breaks egcs-1.1.2 for kernel builds owes
me a quad Xeon, thanks very much.

-

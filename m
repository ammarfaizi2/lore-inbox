Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129742AbRADISv>; Thu, 4 Jan 2001 03:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129962AbRADISm>; Thu, 4 Jan 2001 03:18:42 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:41231 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S129742AbRADIS0>; Thu, 4 Jan 2001 03:18:26 -0500
Message-ID: <3A54332E.58374060@uow.edu.au>
Date: Thu, 04 Jan 2001 19:24:14 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Pete Zaitcev <zaitcev@metabyte.com>, linux-kernel@vger.kernel.org
Subject: Re: So, what about kwhich on RH6.2?
In-Reply-To: <3A541361.65942CB3@metabyte.com> <3A5430C6.FBAB094A@uow.edu.au>,
		<3A5430C6.FBAB094A@uow.edu.au>; from andrewm@uow.edu.au on Thu, Jan 04, 2001 at 07:13:58PM +1100 <20010104091241.B18973@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> On Thu, Jan 04, 2001 at 07:13:58PM +1100, Andrew Morton wrote:
> > Silly question:
> >
> > can't we just hardwire `kgcc' into the build system and be done
> > with all this kwhich stuff?  It's just a symlink....
> 
> And break compilation on all non RedHat 7, non connectiva systems ?

I don't buy that.  The compulsory modutils upgrade a couple of months
back caused, what?  Ten emails?

> Would you volunteer to handle the support load on l-k that would cause?

With pleasure.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

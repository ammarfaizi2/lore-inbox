Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277487AbRJEQxo>; Fri, 5 Oct 2001 12:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277486AbRJEQx0>; Fri, 5 Oct 2001 12:53:26 -0400
Received: from ntt-connection.daiwausa.com ([210.175.188.3]:19010 "EHLO
	ead42.ead.dsa.com") by vger.kernel.org with ESMTP
	id <S277415AbRJEQxP>; Fri, 5 Oct 2001 12:53:15 -0400
From: rugolsky@ead.dsa.com
Date: Fri, 5 Oct 2001 12:52:59 -0400
To: linux-kernel@vger.kernel.org
Cc: lm@bitmover.com, jgiglio@smythco.com
Subject: Re: 3ware discontinuing the Escalade Series
Message-ID: <20011005125259.B1221@ead45>
In-Reply-To: <20011004141942.A28202@lenina.bedford.smythco.com> <20011005090940.B26141@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011005090940.B26141@work.bitmover.com>; from lm@bitmover.com on Fri, Oct 05, 2001 at 09:09:40AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2001 at 09:09:40AM -0700, Larry McVoy wrote:
> On Thu, Oct 04, 2001 at 02:19:42PM -0400, Jason Giglio wrote:
> > 3ware has decided to discontinue their escalade series IDE RAID controller
> > cards.  The drivers were open source and in the kernel tree.
> 
> OK, this sucks because I like those cards a lot.  Before I go out and
> stock up on a bunch of them, is there anything else out there that works
> as well and is supported by Linux?

Not that I know of; the other cards just don't seem to scale as well.
There are a number of comparative reviews to be found on the web.  See,
for example:
http://www.hardwarezone.com/php/pcodes/reviews.php3?_di=2&_c=10&_aid=2001-02-23+20:21:34

What a shame.

I have it on some authority that 3ware doesn't want to sell controllers
any more because they want to move upmarket into the storage arena
where there are better margins, and they don't want to compete against
other integrators using their hardware.

I really like my 7800.  At this point I guess I'm going to convert from
hard to soft RAID, on the theory that (unfixed) bugs in the firmware are less
likely to botch JBOD. 

Regards,

  Bill Rugolsky

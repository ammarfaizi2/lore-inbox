Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292894AbSBVPN6>; Fri, 22 Feb 2002 10:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292893AbSBVPNs>; Fri, 22 Feb 2002 10:13:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21002 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292894AbSBVPNi>;
	Fri, 22 Feb 2002 10:13:38 -0500
Message-ID: <3C766020.FFC64A87@mandrakesoft.com>
Date: Fri, 22 Feb 2002 10:13:36 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@caldera.de>
CC: lm@bitmover.com, hpa@kernel.org, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Linux 2.4 bitkeeper repository
In-Reply-To: <20020222160657.A7914@caldera.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> Hi Larry & Peter,
> 
> the Linux 2.4 repository at linux.bkbbits.net is orphaned short after
> it got created.  Ist there any chance we could see continguous checkins
> for it?
> 
> I think it might be a good idea to get it automatically checked in once
> Marcelo uploads a new (pre-) patch as part of the kernel.org
> notification procedure (is this possible, Peter?).

Stuff will start showing up on kernel.org presumeably when BitMover
works out how to do proper locking on a repository without giving
'other' and 'group' write permission.

I presume one can pretty easily set up a cron to do that... but I wonder
if it is ok with Marcelo?  If Marcelo has plans for that repository, we
ought not touch it probably.

In general, though, agreed :)

> If there is no way to automate it I would volunteer to do the checkins,
> but for that I'd need write permissions to the repository.

As a temporary measure people can pull from
	http://gkernel.bkbits.net/marcelo-2.4

which is always up-to-date with the latest Marcelo pre-patch, and
contains nothing else.

	Jeff



-- 
Jeff Garzik      | "UNIX enhancements aren't."
Building 1024    |           -- says /usr/games/fortune
MandrakeSoft     |

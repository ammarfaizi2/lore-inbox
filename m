Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292898AbSBVP1t>; Fri, 22 Feb 2002 10:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292903AbSBVP1g>; Fri, 22 Feb 2002 10:27:36 -0500
Received: from [212.3.242.3] ([212.3.242.3]:12293 "HELO mail.i4gate.net")
	by vger.kernel.org with SMTP id <S292901AbSBVP1U>;
	Fri, 22 Feb 2002 10:27:20 -0500
Content-Type: text/plain; charset=US-ASCII
From: DevilKin <devilkin-lkml@blindguardian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 bitkeeper repository
Date: Fri, 22 Feb 2002 16:26:38 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020222160657.A7914@caldera.de> <3C766020.FFC64A87@mandrakesoft.com>
In-Reply-To: <3C766020.FFC64A87@mandrakesoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020222152723Z292901-890+3795@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 February 2002 16:13, Jeff Garzik wrote:
> Christoph Hellwig wrote:
> > Hi Larry & Peter,
> >
> > the Linux 2.4 repository at linux.bkbbits.net is orphaned short after
> > it got created.  Ist there any chance we could see continguous checkins
> > for it?
> >
> > I think it might be a good idea to get it automatically checked in once
> > Marcelo uploads a new (pre-) patch as part of the kernel.org
> > notification procedure (is this possible, Peter?).
>
> Stuff will start showing up on kernel.org presumeably when BitMover
> works out how to do proper locking on a repository without giving
> 'other' and 'group' write permission.
>
> I presume one can pretty easily set up a cron to do that... but I wonder
> if it is ok with Marcelo?  If Marcelo has plans for that repository, we
> ought not touch it probably.
>
> In general, though, agreed :)
>
> > If there is no way to automate it I would volunteer to do the checkins,
> > but for that I'd need write permissions to the repository.
>
> As a temporary measure people can pull from
> 	http://gkernel.bkbits.net/marcelo-2.4

Corrected URL: http://gkernel.bkbits.net:8080/marcelo-2.4

(you forgot the BK port, Jeff)

>
> which is always up-to-date with the latest Marcelo pre-patch, and
> contains nothing else.
>
> 	Jeff

DK


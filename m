Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129326AbRBTRAt>; Tue, 20 Feb 2001 12:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129551AbRBTRA3>; Tue, 20 Feb 2001 12:00:29 -0500
Received: from alto.i-cable.com ([210.80.60.4]:33791 "EHLO alto.i-cable.com")
	by vger.kernel.org with ESMTP id <S129326AbRBTRA1>;
	Tue, 20 Feb 2001 12:00:27 -0500
Message-ID: <3A92A2CB.41D38D74@hkicable.com>
Date: Wed, 21 Feb 2001 01:00:59 +0800
From: Thomas Lau <lkthomas@hkicable.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac15 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Kurt Garloff <garloff@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: finding Tekram SCSI dc395U linux patch driver:
In-Reply-To: <XFMail.010215224622.Juergen.Schoew@unix-ag.org> <m3d7cj0zok.fsf@giants.mandrakesoft.com> <3A8D0088.2E147087@hkicable.com> <20010220172745.V1687@garloff.etpnet.phys.tue.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt Garloff wrote:

> On Fri, Feb 16, 2001 at 06:27:20PM +0800, Thomas Lau wrote:
> > Chmouel Boudjnah wrote:
> > > Juergen Schoew <Juergen.Schoew@unix-ag.uni-siegen.de> writes:
> > > > On 15-Feb-01 Thomas Lau wrote:
> > > > > hey, I found this driver on mandrake kernel sources, it's ac3, but I
> > > > > need ac14 code, also, why still not port this driver into kernel?
> > > > > the patch file already released 1 years ago
> > > >
> > > > Have you checked http://www.garloff.de/kurt/linux/dc395/index.html
> > > > there ist a driver Version 1.32 (2000-12-02).
> > >
> > > it's the version included with the mandrake kernel.
> >
> > Well, I think it should add to normal kernel and do not need to patch, Thanks
>
> No, it shouldn't.
> Drivers normally get added to the mainstream kernel if the driver is stable
> enough and somebody acting as maintainer requests to have it included. And,
> then of course, Linus / Alan / ... need to accept it.
>
> I'm maintaining this driver, but in spite of lots of requests to add it to
> the mainstream kernels, I refused to do so. The reason is that some people
> (ca. 5%) using this driver are having serious problems, which I have not
> been able to track down so far. In the worst case, you can end up with data
> corruption. (I could reproduce and fix some of the problems, but not the data
> corruption one.) As that's not funny, I do not want the driver to be in the
> mainstream kernel.
>
> > also, why this driver still stick in ac3?
>
> ?
>
> > and where can I find the new version of this patch?
>
> My version is on
> http://www.garloff.de/kurt/linux/dc395/
>
> > I think mandrake was improved that driver, Thanks
>
> I would be both amazed and pissed off if this would be the case.
> Amazed because somebody was investing time to work on the driver and
> potentially even fix problems.
> Pissed off, because I think it's very bad to fix problems and not submit
> the patches back to the official maintainers.
>
> BTW, if somebody can provide a reasonable description of the chip
> (TRM-S1040), the chances that I'd find the bug would increase a lot ...
>
> Regards,
> --
> Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
> GPG key: See mail header, key servers         Linux kernel development
> SuSE GmbH, Nuernberg, FRG                               SCSI, Security
>
>   ------------------------------------------------------------------------
>    Part 1.2Type: application/pgp-signature

well, I saw the driver not updated for a few months ago, can you release a new
unstable driver to people?
also, Mandrake and SuSE have a lot of expert that you can find them to help you,
they have a lot of resource if you request :)
and I hope you can have a path in kernel.org, so we can get the last release of
DC395 driver, Thanks a lot


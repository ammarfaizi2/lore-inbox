Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265297AbUAFB2U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 20:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266061AbUAFB2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 20:28:20 -0500
Received: from [193.138.115.2] ([193.138.115.2]:45586 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S265297AbUAFB2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 20:28:18 -0500
Date: Tue, 6 Jan 2004 02:25:36 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
cc: Bastiaan Spandaw <lkml@becobaf.com>, Tomas Szepe <szepe@pinerecords.com>,
       Max Valdez <maxvalde@fis.unam.mx>
Subject: Re: 2.6.1-rc1 affected?
In-Reply-To: <1073351377.2690.1.camel@garaged.homeip.net>
Message-ID: <Pine.LNX.4.56.0401060221170.7597@jju_lnx.backbone.dif.dk>
References: <1073351377.2690.1.camel@garaged.homeip.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Jan 2004, Max Valdez wrote:

> At least it hangs a redhat 7.2 kernel
>
> I will test it further tomorrow, but it looks like a good proof to me
>
> Best regards
> Max
> On Mon, 2004-01-05 at 18:23, Bastiaan Spandaw wrote:
> > On Mon, 2004-01-05 at 23:48, Tomas Szepe wrote:
> > > On Jan-05 2004, Mon, 20:38 +0100
> > > GCS <gcs@lsc.hu> wrote:
> > >
> > > > There _is_ an exploit:
> http://isec.pl/vulnerabilities/isec-0013-mremap.txt
> > > > "Since no special privileges are required to use the mremap(2)
> system
> > > ...
> > >
> > > I will not believe the claim until I've seen the code.
> >
> > Not sure if this works or not.
> > According to a slashdot comment this is proof of concept code.
> >
> > http://linuxfromscratch.org/~devine/mremap_poc.c
> >
> > Regards,
> >
> > Bastiaan
> >

On my box that program is a very effective 'instant reboot'.

The instant I ran it from a xterm my screen went black, the music I was
listening to from a CD stopped and the machine rebooted.
The running kernel was 2.6.1-rc1-mm1


- Jesper Juhl


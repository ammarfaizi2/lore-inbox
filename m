Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264520AbRFOUfA>; Fri, 15 Jun 2001 16:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264521AbRFOUeu>; Fri, 15 Jun 2001 16:34:50 -0400
Received: from ns.electricgod.net ([209.134.141.2]:9480 "EHLO
	rogue.electricgod.net") by vger.kernel.org with ESMTP
	id <S264520AbRFOUef>; Fri, 15 Jun 2001 16:34:35 -0400
Date: Fri, 15 Jun 2001 15:33:46 -0500 (CDT)
From: Joshua Jore <moomonk@rogue.electricgod.net>
To: Gregoire Favre <greg@ulima.unil.ch>
cc: Philipp Matthias Hahn <pmhahn@titan.lahn.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Zip: what does that mean?
In-Reply-To: <20010615221557.A8085@ulima.unil.ch>
Message-ID: <Pine.BSF.4.33.0106151532260.10605-100000@rogue.electricgod.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,
Just to make a point on that, as I recall Zip and other super floppy media
*shouldn't* be partitioned. It's certainly possible to do but it's
anyone's guess on how different OS+revs will treat it.

Josh

__SIG__

On Fri, 15 Jun 2001, Gregoire Favre wrote:

> On Fri, Jun 15, 2001 at 08:40:57AM +0200, Philipp Matthias Hahn wrote:
>
> > Nothing. Somethings is reeding /proc/partitions which lists all known
> > partitions. "fdisk" or "mount" do this.
> >
> > When reading the file the kernel has to check the media in your zip-drive.
> > Problem is, you havn't put in one. So there is no partition table to read
> > and the kernel complains and returns the default values of a typical
> > 100MB zip media.
>
> Thanks for your answer, in fact, there was a media in my zip, but
> without any partition (as I don't see any other reason than avoiding
> those errors messages to make just one partition on my disk).
>
> Thanks,
>
> 	Greg
> ________________________________________________________________
> http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
>


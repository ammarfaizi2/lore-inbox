Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316766AbSFFCzO>; Wed, 5 Jun 2002 22:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316768AbSFFCzN>; Wed, 5 Jun 2002 22:55:13 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:35345
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S316766AbSFFCzM>; Wed, 5 Jun 2002 22:55:12 -0400
Date: Wed, 5 Jun 2002 19:55:02 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Thomas Zimmerman <thomas@zimres.net>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] atapci 0.51
Message-ID: <20020606025502.GE448@matchmail.com>
Mail-Followup-To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Thomas Zimmerman <thomas@zimres.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20020601025555.GA291@zimres.net> <Pine.SOL.4.30.0206051820380.16024-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2002 at 06:21:47PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> On Fri, 31 May 2002, Thomas Zimmerman wrote:
> 
> > On 31-May 02:35, Bartlomiej Zolnierkiewicz wrote:
> > [snip]
> > > So 0.51 version is here:
> > > http://home.elka.pw.edu.pl/~bzolnier/atapci/atapci-0.51.tar.bz2
> > >
> > > changelog:
> > > - make it kernel version independent
> > > - add '-s' strip flag to CFLAGS
> > > - minor cosmetics by Roberto Nibali
> > >
> > > --
> > > bkz
> >
> > Just a nit, but wouldn't the name "lsata" fit in better with "lspci" and
> > "lsisa"?
> >
> > Thomas
> >
> 
> No, it is only for PCI chipsets.

I think he meant to follow the naming convention set by lspci and lsisa.
What do you think now?

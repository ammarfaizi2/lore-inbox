Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271306AbRHOREr>; Wed, 15 Aug 2001 13:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271305AbRHOREi>; Wed, 15 Aug 2001 13:04:38 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:36382 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271302AbRHOREY>; Wed, 15 Aug 2001 13:04:24 -0400
Date: Wed, 15 Aug 2001 19:04:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Heinz J . Mauelshagen" <mauelshagen@sistina.com>
Cc: Kurt Garloff <garloff@suse.de>, linux-lvm@sistina.com,
        lvm-devel@sistina.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, sistina@sistina.com, mge@sistina.com
Subject: Re: *** ANNOUNCEMENT *** LVM 1.0 available at www.sistina.com
Message-ID: <20010815190428.A11146@athlon.random>
In-Reply-To: <20010815175659.A29749@sistina.com> <20010815182548.U3941@gum01m.etpnet.phys.tue.nl> <20010815185005.A32239@sistina.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <20010815185005.A32239@sistina.com>; from mauelshagen@sistina.com on Wed, Aug 15, 2001 at 06:50:05PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 15, 2001 at 06:50:05PM +0200, Heinz Mauelshagen wrote:
> offset. No known way around this.

As said in the attached email (never got a reply about it yet btw)
there's definitely a way around it, there's no magic in the beta7
lvmtools, anything they can do can be done as well in the new lvmtools
if we want to (and I believe we want to). I understand you don't want to
clobber the core code with backwards compatibility cruft, but a new
backwards compatibility utility, even in a new directory to make obvious
nothing gets clobbered, could be developed and it would solve the
problem.

Andrea

--SUOF0GtieIMvvwua
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <lvm-devel-admin@sistina.com>
Received: from Hermes.suse.de (Hermes.suse.de [10.10.96.4])
	by Wotan.suse.de (Postfix) with ESMTP id 2B28877C5E
	for <andrea@wotan.suse.de>; Tue, 31 Jul 2001 16:35:24 +0200 (CEST)
Received: by Hermes.suse.de (Postfix)
	id 21D785D624; Tue, 31 Jul 2001 16:35:24 +0200 (MEST)
Received: from Cantor.suse.de (ns.suse.de [213.95.15.193])
	by Hermes.suse.de (Postfix) with ESMTP id 0E78E5D804
	for <andrea@suse.de>; Tue, 31 Jul 2001 16:35:24 +0200 (MEST)
Received: from sistina.com (hermes.sistina.com [208.210.145.141])
	by Cantor.suse.de (Postfix) with SMTP id 721471E67C
	for <andrea@suse.de>; Tue, 31 Jul 2001 16:35:23 +0200 (MEST)
Received: (qmail 9133 invoked from network); 31 Jul 2001 14:35:03 -0000
Received: from localhost (HELO hermes.sistina.com) (127.0.0.1)
  by localhost with SMTP; 31 Jul 2001 14:35:03 -0000
Delivered-To: lvm-devel@sistina.com
Received: (qmail 9072 invoked from network); 31 Jul 2001 14:34:42 -0000
Received: from penguin.e-mind.com (195.223.140.120)
  by hermes.sistina.com with SMTP; 31 Jul 2001 14:34:42 -0000
Received: from black.random ([195.223.140.107])
	by penguin.e-mind.com (8.9.1a/8.9.1/Debian/GNU) with ESMTP id QAA09930
	for <lvm-devel@sistina.com>; Tue, 31 Jul 2001 16:45:36 +0200
Received: from athlon.random ([192.168.1.7])
	by black.random (8.10.2/8.10.2/SuSE Linux 8.10.0-0.3) with ESMTP id f6VEkkT05316
	for <lvm-devel@sistina.com>; Tue, 31 Jul 2001 16:46:46 +0200
Received: (from andrea@localhost)
	by athlon.random (8.11.2/8.10.2/SuSE Linux 8.10.0-0.3) id f6VEZXk18098
	for lvm-devel@sistina.com; Tue, 31 Jul 2001 16:35:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: lvm-devel@sistina.com
Subject: Re: [lvm-devel] *** Pre LVM 0.9.1 Beta 8 release test request ***
Message-ID: <20010731163533.P30071@athlon.random>
In-Reply-To: <20010721192430.B6374@sistina.com> <20010723174845.K822@athlon.random> <20010723180741.A658@btconnect.com> <20010731112514.F30071@athlon.random> <20010731104137.A542@btconnect.com> <20010731151317.M30071@athlon.random> <20010731142050.A853@btconnect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010731142050.A853@btconnect.com>; from thornber@btconnect.com on Tue, Jul 31, 2001 at 02:20:50PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: lvm-devel-admin@sistina.com
Errors-To: lvm-devel-admin@sistina.com
X-BeenThere: lvm-devel@sistina.com
X-Mailman-Version: 2.0.4
Precedence: bulk
Reply-To: lvm-devel@sistina.com
List-Help: <mailto:lvm-devel-request@sistina.com?subject=help>
List-Post: <mailto:lvm-devel@sistina.com>
List-Subscribe: <http://lists.sistina.com/mailman/listinfo/lvm-devel>,
	<mailto:lvm-devel-request@sistina.com?subject=subscribe>
List-Id: general discussion about LVM devel <lvm-devel.sistina.com>
List-Unsubscribe: <http://lists.sistina.com/mailman/listinfo/lvm-devel>,
	<mailto:lvm-devel-request@sistina.com?subject=unsubscribe>
List-Archive: <http://lists.sistina.com/pipermail/lvm-devel/>
Date: Tue, 31 Jul 2001 16:35:33 +0200

On Tue, Jul 31, 2001 at 02:20:50PM +0100, Joe Thornber wrote:
> On Tue, Jul 31, 2001 at 03:13:17PM +0200, Andrea Arcangeli wrote:
> > On Tue, Jul 31, 2001 at 10:41:37AM +0100, Joe Thornber wrote:
> > > On Tue, Jul 31, 2001 at 11:25:14AM +0200, Andrea Arcangeli wrote:
> > > > then why don't you make a pvdisplay option in the new tools that allows
> > > > you to find where the PEs were positioned?
> > > 
> > > The PE location was being calculated, based on various constants such
> > > as BLOCK_SIZE (which varied through the beta series), only the
> > > currently installed tools know where they were putting the PE's :(
> > 
> > What's the problem? Just make a --something option that finds the
> > location of the PE using the previous BLOCK_SIZE.
> 
> But what was the previous block size ?  There's no way of knowing with the 

The one defined in the beta7 lvmtools. The old tools know that, right?
Somebody has to know if the old tools can cope with it. Then just teach
that to the new tools too when the --something is passed to pvdisplay.

> current metadata format ... and BLOCK_SIZE is only one of the variables.

Then define all them, where's the problem? Not being able to use an old
pv after the new tools and new kernel is been installed is a kind of
showstopper situation for the end user as far I can tell.  There's no
real technical reason for which we should take the the pain of this
showstopper situation IMHO, it is perfectly technically possible to
avoid that. Of course I know some more coding and testing is required to
handle that transparently, but it looks a very worthwhile effort to me.

Andrea
_______________________________________________
lvm-devel mailing list
lvm-devel@sistina.com
http://lists.sistina.com/mailman/listinfo/lvm-devel

--SUOF0GtieIMvvwua--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWHANQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWHANQE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 09:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWHANQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 09:16:04 -0400
Received: from mail.gmx.de ([213.165.64.21]:64473 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750795AbWHANQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 09:16:02 -0400
X-Authenticated: #428038
Date: Tue, 1 Aug 2006 15:15:53 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Adrian Ulrich <reiser4@blinkenlights.ch>, nate.diller@gmail.com,
       dlang@digitalinsight.com, vonbrand@inf.utfsm.cl, ipso@snappymail.ca,
       reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
       tytso@mit.edu, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Solaris ZFS on Linux [Was: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion]
Message-ID: <20060801131553.GA8249@merlin.emma.line.org>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Adrian Ulrich <reiser4@blinkenlights.ch>, nate.diller@gmail.com,
	dlang@digitalinsight.com, vonbrand@inf.utfsm.cl, ipso@snappymail.ca,
	reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
	tytso@mit.edu, linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com
References: <44CE7C31.5090402@gmx.de> <5c49b0ed0607311621i54f1c46fh9137f8955c9ea4be@mail.gmail.com> <Pine.LNX.4.63.0607311621360.14674@qynat.qvtvafvgr.pbz> <5c49b0ed0607311650j4b86d0c3h853578f58db16140@mail.gmail.com> <Pine.LNX.4.63.0607311651410.14674@qynat.qvtvafvgr.pbz> <5c49b0ed0607311705t1eb8fc6bs9a68a43059bfa91a@mail.gmail.com> <20060801010215.GA24946@merlin.emma.line.org> <20060801095141.5ec0b479.reiser4@blinkenlights.ch> <20060801090947.GA2974@merlin.emma.line.org> <Pine.LNX.4.61.0608011255130.29748@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0608011255130.29748@yvahk01.tjqt.qr>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12 (2006-07-17)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt schrieb am 2006-08-01:

> >I didn't mean to say your particular drive were crap, but 200GB SATA
> >drives are low end, like it or not --
> 
> And you think an 18 GB SCSI disk just does it better because it's SCSI?

18 GB SCSI disks are 1999 gear, so who cares?
Seagate didn't sell 200 GB SATA drives at that time.

> Esp. in long sequential reads.

You think SCSI drives aren't on par? Right, they're ahead.
98 MB/s for the fastest SCSI drives vs. 88 MB/s for Raptor 150 GB SATA
and 74 MB/s for the fastest other ATA drives.

(Figures obtained from StorageReview.com's Performance Database.)

-- 
Matthias Andree

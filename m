Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751605AbVKDQXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbVKDQXM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 11:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbVKDQXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 11:23:12 -0500
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:40590 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751605AbVKDQXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 11:23:10 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 4 Nov 2005 16:22:58 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Michael Thompson <michael.craig.thompson@gmail.com>
cc: Greg KH <greg@kroah.com>, Phillip Hellewell <phillip@hellewell.homeip.net>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       mike@halcrow.us, mhalcrow@us.ibm.com, mcthomps@us.ibm.com,
       yoder1@us.ibm.com
Subject: Re: [PATCH 1/12: eCryptfs] Makefile and Kconfig
In-Reply-To: <afcef88a0511040809p4e9cf962me25c037cbfb9e967@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0511041621550.14940@hermes-1.csi.cam.ac.uk>
References: <20051103033220.GD2772@sshock.rn.byu.edu> 
 <20051103034207.GA3005@sshock.rn.byu.edu>  <afcef88a0511030721g68ddf71bjf02397abcd8da30@mail.gmail.com>
  <20051103230551.GB30487@kroah.com> <afcef88a0511040809p4e9cf962me25c037cbfb9e967@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2005, Michael Thompson wrote:
> On 11/3/05, Greg KH <greg@kroah.com> wrote:
> > On Thu, Nov 03, 2005 at 09:21:16AM -0600, Michael Thompson wrote:
> > > On 11/2/05, Phillip Hellewell <phillip@hellewell.homeip.net> wrote:
> > > > These patches modify fs/Makefile and fs/Kconfig to provide build
> > > > support for eCryptfs.
> > > >
> > > > Signed off by: Phillip Hellewell <phillip@hellewell.homeip.net>
> > > > Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>
> > > > Signed off by: Michael Thompson <mmcthomps@us.ibm.com>
> > >
> > > That should read:
> > > Signed off by: Michael Thompson <mcthomps@us.ibm.com>
> >
> > No, that's not how it is documented on how to do this.  Please try
> > again.
> 
> I've just rummaged around in linux/Documentation and I have not been
> able to find, either in a specific file, or by looking at "The Perfect
> Patch", or other related links, on how to fix an incorrect
> "Signed-off-by" line.
> 
> Like I've already said, I have no problems with a RTFM response, but
> point me to the right M.

I have no idea what Greg was talking about either but one thing that is 
obviously wrong is that as you say it should be "Signed-off-by:" and not 
"Signed off by:", i.e. you have to have dashes between the words, not 
spaces.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

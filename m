Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbVKULas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbVKULas (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 06:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbVKULas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 06:30:48 -0500
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:39395 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932262AbVKULar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 06:30:47 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 21 Nov 2005 11:30:43 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andreas Happe <andreashappe@snikt.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
In-Reply-To: <slrndo37kk.cvi.news_0403@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0511211129400.15044@hermes-1.csi.cam.ac.uk>
References: <11b141710511210144h666d2edfi@mail.gmail.com>
 <20051121095915.83230.qmail@web36406.mail.mud.yahoo.com>
 <slrndo37kk.cvi.news_0403@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2005, Andreas Happe wrote:
> On 2005-11-21, Alfred Brons <alfredbrons@yahoo.com> wrote:
> > Thanks Paulo!
> > I wasn't aware of this thread.
> >
> > But my question was: do we have similar functionality
> > in Linux kernel?
[snip]
> >>> Filesystems can be created instantaneously, snapshots and clones
> >>> taken, native backups made, and a simplified property mechanism
> >>> allows for setting of quotas, reservations, compression, and more.
> 
> excepct per-file compression all thinks should be doable with normal in-kernel
> fs. per-file compression may be doable with ext2 and special patches, an
> overlay filesystem or reiser4.

NTFS has per-file compression although I admit that in Linux this is 
read-only at present (mostly because it is low priority).

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

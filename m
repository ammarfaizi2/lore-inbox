Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbUC2Ozl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 09:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262915AbUC2Ozl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 09:55:41 -0500
Received: from gold.csi.cam.ac.uk ([131.111.8.12]:37300 "EHLO
	gold.csi.cam.ac.uk") by vger.kernel.org with ESMTP id S262910AbUC2Ozk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 09:55:40 -0500
Subject: Re: [Linux-NTFS-Dev] Geometry determination
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: ntfs-dev <linux-ntfs-dev@lists.sourceforge.net>,
       Andries Brouwer <aeb@cwi.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0403291512030.6684-100000@mlf.linux.rulez.org>
References: <Pine.LNX.4.21.0403291512030.6684-100000@mlf.linux.rulez.org>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Message-Id: <1080572234.5545.23.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 29 Mar 2004 15:57:15 +0100
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-29 at 14:48, Szakacsits Szabolcs wrote:
> On Mon, 29 Mar 2004, Anton Altaparmakov wrote:
> 
> > I have been experimenting a little with what Windows / Linux 2.4 / Linux
> > 2.6 think the geometry of a couple of HDs is and the results are not
> > very promising.  )-:
> > 
> > Using Linux 2.4, HDIO_GETGEO ioctl, I get the same Heads and Sectors per
> > Track as Windows on both HDs I tried it on.  This is the good news. 
> > I.e. at least on those two disks mkntfs as it stands now would create
> > Windows bootable partitions.
> > 
> > The bad news is that Linux 2.4, HDIO_GETGEO ioctl returns wrong values
> 
> You mean 2.6?

Yes, sorry, I do mean 2.6.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ &
http://www-stu.christs.cam.ac.uk/~aia21/


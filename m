Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270270AbRHRSCp>; Sat, 18 Aug 2001 14:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270271AbRHRSCf>; Sat, 18 Aug 2001 14:02:35 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:8347 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S270270AbRHRSC0>; Sat, 18 Aug 2001 14:02:26 -0400
Date: Sat, 18 Aug 2001 12:02:27 -0600
Message-Id: <200108181802.f7II2Rv12385@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subjectd: devfsd-v1.3.17 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. I've just released version 1.3.17 of my devfsd (devfs
daemon) at: http://www.atnf.csiro.au/~rgooch/linux/

Tarball directly available from:
ftp://ftp.??.kernel.org/pub/linux/daemons/devfsd/devfsd.tar.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/daemons/devfsd/devfsd.tar.gz

This works with devfs-patch-v130, kernel 2.3.46 and devfs-patch-v99.7
(or later).

The main changes are:

- Dynamically load libnsl at run-time as needed, rather than
  linking. Based on patch from Adam J. Richter.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

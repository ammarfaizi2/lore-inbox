Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270274AbRHRSJ5>; Sat, 18 Aug 2001 14:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270293AbRHRSJq>; Sat, 18 Aug 2001 14:09:46 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:10651 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S270279AbRHRSJe>; Sat, 18 Aug 2001 14:09:34 -0400
Date: Sat, 18 Aug 2001 12:09:49 -0600
Message-Id: <200108181809.f7II9nq12577@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: devfsd-v1.3.17 available
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

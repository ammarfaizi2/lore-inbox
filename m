Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270359AbRHHGoP>; Wed, 8 Aug 2001 02:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270358AbRHHGoF>; Wed, 8 Aug 2001 02:44:05 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:44680 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S270361AbRHHGnw>; Wed, 8 Aug 2001 02:43:52 -0400
Date: Wed, 8 Aug 2001 00:43:58 -0600
Message-Id: <200108080643.f786hwk15743@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: devfsd-v1.3.13 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. I've just released version 1.3.13 of my devfsd (devfs
daemon) at: http://www.atnf.csiro.au/~rgooch/linux/

Tarball directly available from:
ftp://ftp.??.kernel.org/pub/linux/daemons/devfsd/devfsd.tar.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/daemons/devfsd/devfsd.tar.gz

This works with devfs-patch-v130, kernel 2.3.46 and devfs-patch-v99.7
(or later).

The main changes are:

- Added support for DELETE event

- Added debug trace to <action_modload>

- Added compatibility entry support for SCSI discs 16 to 127

- Added support for recursively reading config directories

- Documentation updates.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

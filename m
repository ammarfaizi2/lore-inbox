Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289395AbSAOEXN>; Mon, 14 Jan 2002 23:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289399AbSAOEXD>; Mon, 14 Jan 2002 23:23:03 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:51388 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S289395AbSAOEWx>; Mon, 14 Jan 2002 23:22:53 -0500
Date: Mon, 14 Jan 2002 21:22:38 -0700
Message-Id: <200201150422.g0F4Mcc05113@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: devfsd-v1.3.21 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. I've just released version 1.3.21 of my devfsd (devfs
daemon) at: http://www.atnf.csiro.au/~rgooch/linux/

Tarball directly available from:
ftp://ftp.??.kernel.org/pub/linux/daemons/devfsd/devfsd.tar.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/daemons/devfsd/devfsd.tar.gz

This works with devfs-patch-v130, kernel 2.3.46 and devfs-patch-v99.7
(or later).

The main changes are:

- GNUmakefile changes

- Created INSTALL file

- Man page improvements

- Switched to extended regular expression support

- Fixed dummy opens of /dev/null

- Sample devfsd.conf updated to use mksymlink().

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

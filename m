Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310141AbSBRGMp>; Mon, 18 Feb 2002 01:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310142AbSBRGMf>; Mon, 18 Feb 2002 01:12:35 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:27609 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S310141AbSBRGMW>; Mon, 18 Feb 2002 01:12:22 -0500
Date: Sun, 17 Feb 2002 23:12:04 -0700
Message-Id: <200202180612.g1I6C4L25410@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: devfsd-v1.3.24 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. I've just released version 1.3.24 of my devfsd (devfs
daemon) at: http://www.atnf.csiro.au/~rgooch/linux/

Tarball directly available from:
ftp://ftp.??.kernel.org/pub/linux/daemons/devfsd/devfsd.tar.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/daemons/devfsd/devfsd.tar.gz

This works with devfs-patch-v130, kernel 2.3.46 and devfs-patch-v99.7
(or later).

The main changes are:

- Do not re-read config file if signals other than SIGHUP are caught

- Added sample configuration entries to devfsd.conf for PTY
  ownerships.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

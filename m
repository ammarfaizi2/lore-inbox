Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270309AbRHMQsG>; Mon, 13 Aug 2001 12:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270299AbRHMQr4>; Mon, 13 Aug 2001 12:47:56 -0400
Received: from guestpc.physics.umanitoba.ca ([130.179.72.122]:11268 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S270293AbRHMQrr>; Mon, 13 Aug 2001 12:47:47 -0400
Date: Mon, 13 Aug 2001 11:47:53 -0500
Message-Id: <200108131647.f7DGlrR01294@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@mobilix.ras.ucalgary.ca
Subject: devfsd-v1.3.15 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. I've just released version 1.3.15 of my devfsd (devfs
daemon) at: http://www.atnf.csiro.au/~rgooch/linux/

Tarball directly available from:
ftp://ftp.??.kernel.org/pub/linux/daemons/devfsd/devfsd.tar.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/daemons/devfsd/devfsd.tar.gz

This works with devfs-patch-v130, kernel 2.3.46 and devfs-patch-v99.7
(or later).

The main changes are:

- Updated compatibility entry support for proposed Stallion serial
  driver names

- Added compatibility entry support for Rocketport serial driver.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

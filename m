Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129233AbRBFGbK>; Tue, 6 Feb 2001 01:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129596AbRBFGbA>; Tue, 6 Feb 2001 01:31:00 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:14720 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S129233AbRBFGax>; Tue, 6 Feb 2001 01:30:53 -0500
Date: Mon, 5 Feb 2001 23:30:24 -0700
Message-Id: <200102060630.f166UO002259@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: devfsd-v1.3.11 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. I've just released version 1.3.11 of my devfsd (devfs
daemon) at: http://www.atnf.csiro.au/~rgooch/linux/

This works with devfs-patch-v130 and devfs-patch-v99.7 (or later).

The main changes are:

- Workaround changes in glibc 2.2

- Handle cases where fds [0:2] are closed already.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

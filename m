Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289075AbSAUG1L>; Mon, 21 Jan 2002 01:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289076AbSAUG1B>; Mon, 21 Jan 2002 01:27:01 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:17289 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S289075AbSAUG0q>; Mon, 21 Jan 2002 01:26:46 -0500
Date: Sun, 20 Jan 2002 23:26:42 -0700
Message-Id: <200201210626.g0L6Qg621934@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Boot hang in 2.5.3-pre2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, Linus. FYI: 2.5.3-pre2 hangs during boot. The last couple of
messages I get are:
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.15)
apm: disabled - APM is not SMP safe (power off active).

Going back to 2.5.2, the next boot line is:
Starting kswapd

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

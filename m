Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRACXQ2>; Wed, 3 Jan 2001 18:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRACXQS>; Wed, 3 Jan 2001 18:16:18 -0500
Received: from sentry.gw.tislabs.com ([192.94.214.100]:40085 "EHLO
	sentry.gw.tislabs.com") by vger.kernel.org with ESMTP
	id <S129267AbRACXQB>; Wed, 3 Jan 2001 18:16:01 -0500
From: <tfraser@tislabs.com>
Date: Wed, 3 Jan 2001 19:31:20 -0500
Message-Id: <200101040031.TAA02262@bucky.gw.tislabs.com>
To: linux-kernel@vger.kernel.org
Cc: tfraser@tislabs.com
Subject: Announce:  LOMAC v1.0 released
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

    I've just released LOMAC v1.0 - an LKM for Linux 2.2 kernels that
implements a form of Low Water-Mark Mandatory Access Control (MAC) to
protect the integrity of processes and data from viruses, Trojan
horses, malicious remote users, and compromised root daemons.  LOMAC
is designed for simplicity and compatibility with existing software.
It implements kernel-space MAC at the system-call interface without
modifying any kernel sources.

    Although it lacks some of the advanced MAC features found in more
complex and powerful schemes, LOMAC provides a simple and useful form
of MAC integrity protection that requires no kernel patches, no
modifications to existing applications, no modifications to existing
configuration files, and no site-specific policy configuration.  A
good number of features and fixes remain to be implemented.  However,
LOMAC is presently functional enough to thwart script kiddies, and is
sufficiently stable for everyday use.  (I'm using it now.)

    Further information can be found via LOMAC's Freshmeat page, at
             http://freshmeat.net/projects/lomac

                   - Tim Fraser, NAI Labs


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

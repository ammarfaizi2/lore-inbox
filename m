Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268492AbRGXWEU>; Tue, 24 Jul 2001 18:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268491AbRGXWEK>; Tue, 24 Jul 2001 18:04:10 -0400
Received: from pC19F065A.dip.t-dialin.net ([193.159.6.90]:55819 "EHLO
	srv.sistina.com") by vger.kernel.org with ESMTP id <S268489AbRGXWD4>;
	Tue, 24 Jul 2001 18:03:56 -0400
Date: Tue, 24 Jul 2001 23:57:38 +0200
From: "Heinz J . Mauelshagen" <mauelshagen@sistina.com>
To: linux-lvm@sistina.com, lvm-devel@sistina.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc: mge@sistina.com
Subject: *** ANNOUNCEMENT *** LVM 0.9.1 Beta 8 available at www.sistina.com
Message-ID: <20010724235738.A21917@sistina.com>
Reply-To: mauelshagen@sistina.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Hi all,

a tarball of the Linux Logical Volume Manager 0.9.1 Beta 8 is available now at

   <http://www.sistina.com/>

for download (Follow the "LVM 0.9.1-Beta8" link).

This release fixes several bugs including a PE alignment bug which
was introduced with LVM 0.9.1 Beta 6.

In order to support all existing PEs, this release forces a minor
metadata format change. 

We strictly recommend that you read the metadata upgrade instructions
in README.1st contained in the tarball *before* you try to upgrade
your existing installations!
Support to downgrade the metadata format is included too.

See the CHANGELOG file contained in the tarball for further information.

Please help us to stabilize for LVM 1.0 ASAP and provide your test results,
bug fixes and advice.

Feed back related information to <linux-lvm@sistina.com>.

Thanks a lot for your support of LVM.

-- 

Regards,
Heinz    -- The LVM Guy --

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Sistina Software Inc.
Senior Consultant/Developer                       Am Sonnenhang 11
                                                  56242 Marienrachdorf
                                                  Germany
Mauelshagen@Sistina.com                           +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBALJv>; Thu, 1 Feb 2001 06:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129063AbRBALJk>; Thu, 1 Feb 2001 06:09:40 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:16312 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129032AbRBALJb>; Thu, 1 Feb 2001 06:09:31 -0500
Date: Thu, 1 Feb 2001 12:04:55 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: James Sutherland <jas88@cam.ac.uk>
cc: Grzegorz Sojka <grzes@prioris.mini.pw.edu.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: BUG
In-Reply-To: <Pine.SOL.4.21.0101312317340.24868-100000@orange.csi.cam.ac.uk>
Message-ID: <Pine.GSO.3.96.1010201120045.17657B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, James Sutherland wrote:

> > Jan 31 23:39:18 Zeus kernel: APIC error on CPU1: 08(02)
> > Jan 31 23:39:46 Zeus kernel: APIC error on CPU0: 04(02)
[...]
> (These are common, but fairly harmless FWIH, on BP6s.)

 Yep, until you get a lockup due to an undetected error...

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265136AbUASOYb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 09:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265140AbUASOYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 09:24:31 -0500
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:7392 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S265136AbUASOYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 09:24:25 -0500
Subject: Re: NTFS disk usage on Linux 2.6
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Haakon Riiser <haakon.riiser@fys.uio.no>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20040118005537.GA11977@s.chello.no>
References: <20040115010210.GA570@s.chello.no>
	 <200401151401.1764@sandersweb.net>  <20040118005537.GA11977@s.chello.no>
Content-Type: text/plain
Organization: University of Cambridge
Message-Id: <1074522293.3283.0.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 19 Jan 2004 14:24:53 +0000
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-01-18 at 00:55, Haakon Riiser wrote:
> Thanks go to everyone who confirmed this bug.  Since we now know the
> bug is real, I have created an entry for it in Bugzilla:
> http://bugzilla.kernel.org/show_bug.cgi?id=1899

I have closed this bug as I have fixed it in the NTFS release 2.1.6 that
I just posted to LKML.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ &
http://www-stu.christs.cam.ac.uk/~aia21/



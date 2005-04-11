Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbVDKJ1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbVDKJ1f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 05:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVDKJ1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 05:27:34 -0400
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132]:44248 "EHLO
	ppsw-2.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261745AbVDKJ1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 05:27:33 -0400
Subject: Re: more git updates..
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Bernd Eckenfels <ecki@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1DKlU7-0007lM-00@calista.eckenfels.6bone.ka-ip.net>
References: <E1DKlU7-0007lM-00@calista.eckenfels.6bone.ka-ip.net>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Mon, 11 Apr 2005 10:27:23 +0100
Message-Id: <1113211643.10415.1.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-11 at 01:04 +0200, Bernd Eckenfels wrote:
> In article <20050410111905.53a2f6a1.pj@engr.sgi.com> you wrote:
> > (I repeat the xxx in the leaf name - easier to code.)
> 
> It is a bit OT, but just a note: there are file systems (hash functions) out
> there who dont like a lot of files named the same way. For example NTFS with
> the 8.3 short names.

Since you mention NTFS, there is no need to worry about that for Linux.
Certainly the Linux kernel NTFS driver is never going to create 8.3
short names.  (It doesn't create names at all at the moment but my grand
plan is that it will only ever create file names in the Win32 and/or
POSIX name spaces.  The DOS name space is a thing of the past IMO.)

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/


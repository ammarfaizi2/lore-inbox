Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbVI3Ps7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbVI3Ps7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 11:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030343AbVI3Ps7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 11:48:59 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:55228 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030342AbVI3Ps7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 11:48:59 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: New and bogus(!) warning produced by sparse.
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0509300837230.3378@g5.osdl.org>
References: <Pine.LNX.4.60.0509301459020.23217@hermes-1.csi.cam.ac.uk>
	 <Pine.LNX.4.64.0509300727450.3378@g5.osdl.org>
	 <Pine.LNX.4.64.0509300837230.3378@g5.osdl.org>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Fri, 30 Sep 2005 16:48:54 +0100
Message-Id: <1128095334.3584.0.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-30 at 08:37 -0700, Linus Torvalds wrote:
> 
> On Fri, 30 Sep 2005, Linus Torvalds wrote:
> > 
> > I see why it happens, will fix sparse momentarily 
> 
> Fixed, pushed out.

Pulled, compiled and warning is gone.  Thanks!

And sorry I sent it to lkml, I had forgotten about linux-sparse ml and
it started out as a kernel related email given I saw it when compiling
kernel source.  (-;

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbVCCLxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbVCCLxQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 06:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVCCLtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 06:49:21 -0500
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:42436 "EHLO
	ppsw-3.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261643AbVCCLsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 06:48:53 -0500
Date: Thu, 3 Mar 2005 11:48:39 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linus Torvalds <torvalds@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
In-Reply-To: <4226EE64.9010207@pobox.com>
Message-ID: <Pine.LNX.4.60.0503031146360.26782@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
 <42264F6C.8030508@pobox.com> <20050302162312.06e22e70.akpm@osdl.org>
 <42265A6F.8030609@pobox.com> <20050302165830.0a74b85c.davem@davemloft.net>
 <422674A4.9080209@pobox.com> <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
 <Pine.LNX.4.60.0503031045580.26782@hermes-1.csi.cam.ac.uk> <4226EE64.9010207@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2005, Jeff Garzik wrote:
> Anton Altaparmakov wrote:
> > I think the .EVEN and .ODD proposal would work a lot better than -rc ever
> > would/could.
> 
> ...until people find out the "secret" that .ODD is really beta.  Then we are
> back where we started.

Ah, but you are assuming people think logically and they don't.  "2.6.ODD 
doesn't say beta so it can't be beta, right?"  I think this directly 
translates to the actually happening "0.x is not 1.x so it can't be 
usable, right?"  Both statements are crap but the second is real world and 
the first by analogy could be real world.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266555AbUJIGiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266555AbUJIGiQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 02:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266572AbUJIGiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 02:38:16 -0400
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:29653 "EHLO
	ppsw-3.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S266555AbUJIGiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 02:38:14 -0400
Date: Sat, 9 Oct 2004 07:38:09 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: [patch 1/1] dm: fix printk warnings about whether %lu/%Lu is
 right for sector_t
In-Reply-To: <200410090204.46720.blaisorblade_spam@yahoo.it>
Message-ID: <Pine.LNX.4.60.0410090736560.584@hermes-1.csi.cam.ac.uk>
References: <20041008144034.EB891B557@zion.localdomain>
 <200410082245.39119.blaisorblade_personal@yahoo.it>
 <Pine.LNX.4.60.0410082221340.26699@hermes-1.csi.cam.ac.uk>
 <200410090204.46720.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Oct 2004, BlaisorBlade wrote:
> On Friday 08 October 2004 23:57, Anton Altaparmakov wrote:
> > On Fri, 8 Oct 2004, Paolo Giarrusso wrote:
> > > On Friday 08 October 2004 22:11, Anton Altaparmakov wrote:
> > > > On Fri, 8 Oct 2004, Andrew Morton wrote:
> > > > > blaisorblade_spam@yahoo.it wrote:
> 
> > Yes I know in the kernel and on i386 it makes no difference, I said that
> > already.  But on some systems it does make a difference.  I have seen it
> > myself and I have had it reported. 
> 
> > Thinking about it when I said 
> > architectures I possibly meant to say "other Unix flavours", I think one
> > of the *BSDs was the one where I saw the difference between %L and %ll
> > manifest itself.
> Ok, I thought hardware archs - for other Unixes you're right.
> 
> Sorry for this and thanks for the lesson. Bye
> > Sorry, it is not.  I find it somewhat strange that you choose gcc and
> > glibc to say what is correct...  Ever heard of standards?!?
> Yes, I heard them, I just never bought ISO standards.

Just search google and you will find plenty of places offering them for 
free download...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

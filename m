Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265035AbUEKXHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265035AbUEKXHY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 19:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265037AbUEKXHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 19:07:24 -0400
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:12465 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S265035AbUEKXHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 19:07:18 -0400
Date: Wed, 12 May 2004 00:07:17 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.6-bk] NTFS: 2.1.10 - Force read-only (re)mounting of volumes
 with unsupported volume flags.
In-Reply-To: <Pine.SOL.4.58.0405112221070.4261@yellow.csi.cam.ac.uk>
Message-ID: <Pine.SOL.4.58.0405120006480.7932@yellow.csi.cam.ac.uk>
References: <Pine.SOL.4.58.0405112221070.4261@yellow.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2004, Anton Altaparmakov wrote:
> Hi Andrew, Hi Linus, please do a
>
> 	bk pull http://linux-ntfs.bkbits.net/ntfs

Ooops Sorry. This was meant to say:

	bk pull http://linux-ntfs.bkbits.net/ntfs-2.6

>
> Thanks!  This enforces read-only mounting if the NTFS volume information
> flags have any unsupported bits set and it completes the white space
> cleanups.  From here on changes will be adding more advanced write code so
> releases are likely to slow down again...
>
> Best regards,
>
> 	Anton
>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

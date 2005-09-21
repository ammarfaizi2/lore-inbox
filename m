Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbVIUTe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbVIUTe7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 15:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbVIUTe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 15:34:59 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:32962 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751402AbVIUTe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 15:34:58 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Wed, 21 Sep 2005 20:34:02 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Jean Delvare <khali@linux-fr.org>
cc: kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org,
       Bas Vermeulen <bvermeul@blackstar.nl>
Subject: Re: 2.6.14-rc1 - kernel BUG at fs/ntfs/aops.c:403
In-Reply-To: <20050921203737.5a82ba60.khali@linux-fr.org>
Message-ID: <Pine.LNX.4.60.0509212033490.27896@hermes-1.csi.cam.ac.uk>
References: <20050917145150.GA5481@dreamland.darkstar.lan>
 <1127122747.493.5.camel@imp.csi.cam.ac.uk> <20050921203737.5a82ba60.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 21 Sep 2005, Jean Delvare wrote:
> > Below is the fix I just sent off to Linus.
> 
> 2.6.14-rc2 works for me.

Great, thanks.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

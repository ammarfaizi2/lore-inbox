Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbVI2TIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbVI2TIO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbVI2TIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:08:14 -0400
Received: from mail1.kontent.de ([81.88.34.36]:29673 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S932195AbVI2TIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:08:13 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Thu, 29 Sep 2005 21:08:10 +0200
User-Agent: KMail/1.8
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
References: <433BC9E9.6050907@pobox.com>
In-Reply-To: <433BC9E9.6050907@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509292108.11092.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 29. September 2005 13:03 schrieb Jeff Garzik:
> 
> Just updated my KHGtG to include the latest goodies available in 
> git-core, the Linux kernel standard SCM tool:
> 
> 	http://linux.yyz.us/git-howto.html
> 
> Several changes in git-core have made working with git a lot easier, so 
> be sure to re-familiarize yourself with the development process.
> 
> Comments, corrections, and notes of omission welcome.  This document 
> mainly reflects my typical day-to-day git activities, and may not be 
> very applicable outside of kernel work.

Unfortunately, following the instructions to the letter produces this:
oliver@oenone:~/linux-2.6> git checkout
usage: read-tree (<sha> | -m <sha1> [<sha2> <sha3>])

	Regards
		Oliver

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbUEQMho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbUEQMho (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 08:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbUEQMho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 08:37:44 -0400
Received: from zeus.kernel.org ([204.152.189.113]:4303 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261156AbUEQMhm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 08:37:42 -0400
Date: Mon, 17 May 2004 13:22:11 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [2.6.6-mm3] fix-sysfs-symlinks.patch
Message-ID: <20040517122211.GS17014@parcelfarce.linux.theplanet.co.uk>
References: <20040517114929.GA1249@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040517114929.GA1249@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2004 at 05:19:29PM +0530, Maneesh Soni wrote:
> Hi Andrew,
> 
> I have fixed the rejects and re-diffed the following patch. There are no code
> changes as such.

ACK.  Let's merge that puppy (and my vote is to merge it upstream) and move
on to the rest of patchset.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbULBSIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbULBSIh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 13:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbULBSIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 13:08:37 -0500
Received: from pat.uio.no ([129.240.130.16]:52710 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261682AbULBSIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 13:08:36 -0500
Subject: Re: nfs and LBD support (2TB+)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Stephan van Hienen <kernel@a2000.nu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0412021850120.16787@adsl.a2000.nu>
References: <Pine.LNX.4.61.0412020017550.2774@adsl.a2000.nu>
	 <1101945033.32266.33.camel@lade.trondhjem.org>
	 <Pine.LNX.4.61.0412021850120.16787@adsl.a2000.nu>
Content-Type: text/plain
Date: Thu, 02 Dec 2004 13:08:19 -0500
Message-Id: <1102010900.11358.40.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 02.12.2004 Klokka 18:51 (+0100) skreiv Stephan van Hienen:

> and is there a fix ?
> (it looks like it's working ok, but still i would like to see the actual 
> free space/usage)

...for glibc? Wrong list.

If you want to revert the patch that changes the NFS value of frsize to
reflect the server's value, then that is

http://linux.bkbits.net:8080/linux-2.6/user=trond.myklebust/gnupatch@412a6c715tssAB_N5Kg-Z1JqFn4FmA


Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>


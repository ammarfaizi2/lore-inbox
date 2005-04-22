Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbVDVP3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbVDVP3y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 11:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbVDVP3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 11:29:22 -0400
Received: from pat.uio.no ([129.240.130.16]:12025 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261968AbVDVP2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 11:28:14 -0400
Subject: Re: Irix NFS Server Problems - Ever Resolved?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Eric Harvieux <eric@ima.umn.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4269103D.1000503@ima.umn.edu>
References: <4269103D.1000503@ima.umn.edu>
Content-Type: text/plain
Date: Fri, 22 Apr 2005 11:27:57 -0400
Message-Id: <1114183677.10450.80.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.51, required 12,
	autolearn=disabled, AWL 1.44, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fr den 22.04.2005 Klokka 09:54 (-0500) skreiv Eric Harvieux:
> Hi,
> 
> I have recently run into problems with 2.6 NFS clients accessing Irix 
> servers. After extensive searching, I found the problem referred to on 
> the kernel mailing list, in this thread:
> 
> http://kerneltrap.org/mailarchive/1/message/19372/thread
> 
> I could not find any other discussion of this issue and was wondering if 
> there has been any further work done to write a patch for this issue? 
> This bug definitely breaks 2.6 NFS clients, while 2.4 clients works fine.

Yes. See the list of patches on

http://client.linux-nfs.org/Linux-2.6.x/2.6.12-rc2

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269395AbUICAQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269395AbUICAQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 20:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269389AbUICAO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 20:14:58 -0400
Received: from zeus.kernel.org ([204.152.189.113]:61352 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S269438AbUICAGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 20:06:16 -0400
From: "David B. Stevens" <dsteven3@maine.rr.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: Kernel or Grub bug.
Date: Thu, 2 Sep 2004 19:25:59 -0400
User-Agent: KMail/1.6.2
Cc: "Wise, Jeremey" <jeremey.wise@agilysys.com>, linux-kernel@vger.kernel.org
References: <200409022103.i82L2rm1003486@laptop11.inf.utfsm.cl>
In-Reply-To: <200409022103.i82L2rm1003486@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200409021925.59342.dsteven3@maine.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 September 2004 17:02, Horst von Brand wrote:
> "Wise, Jeremey" <jeremey.wise@agilysys.com> said:
>
> [...]
>
> > My system is all reiserfs though the Fedora core box I also did testing
> > on was EXT3.
>
> grub can't handle ReiserFS.

But it is supposed to according to the docs.


Support multiple filesystem types
    Support multiple filesystem types transparently, plus a useful explicit 
blocklist notation. The currently supported filesystem types are BSD FFS, DOS 
FAT16 and FAT32, Minix fs, Linux ext2fs, ReiserFS, JFS, XFS, and VSTa fs. See 
Filesystem, for more information. 

Cheers,
  Dave

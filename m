Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265310AbUBEP6k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 10:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265292AbUBEP6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 10:58:40 -0500
Received: from email-out1.iomega.com ([147.178.1.82]:63947 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265289AbUBEP6g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 10:58:36 -0500
Subject: Re: [ANNOUNCE] Filesystem in Userspace (FUSE) 1.1 stable version
From: Pat LaVarre <p.lavarre@ieee.org>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200402051258.i15Cw2E20493@kempelen.iit.bme.hu>
References: <200402051258.i15Cw2E20493@kempelen.iit.bme.hu>
Content-Type: text/plain
Organization: 
Message-Id: <1075996629.6941.10.camel@patibmrh9>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Feb 2004 08:57:09 -0700
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Feb 2004 15:58:34.0719 (UTC) FILETIME=[E8D8E6F0:01C3EC00]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> FUSE is a combination of a kernel module and a
> userspace library that makes the creation of
> filesystems in userspace very easy.

Any connection here with making linux fs easier to learn?

I ask because I've not found any reasonably quick way of making sense
of:

http://lxr.linux.no/source/fs/udf/

developed at:

http://sourceforge.net/projects/linux-udf/

I see I can trivially make that fs fail fsck and patch fs/udf to teach
gdb to print the structures on disc.  I see less trivially I can
persuade that fs to read back what I did not write.  But as yet I have
not more directly helped improve the fs/udf/ code.

Pat LaVarre
http://udfko.blog-city.com/index.cfm?y=2004

P.S.

> http://sourceforge.net/project/showfiles.php?group_id=21636&package_id=31956&release_id=214856

Thank you from that I found:

the AVFS project page on sourceforge
http://sourceforge.net/projects/avf/

AVFS - A Virtual File System
http://www.inf.bme.hu/~mszeredi/avfs/

Also I see this FUSE is not sourceforge.net/projects/fuse/.



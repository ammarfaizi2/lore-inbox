Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbULEArv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbULEArv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 19:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbULEArv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 19:47:51 -0500
Received: from imf16aec.mail.bellsouth.net ([205.152.59.64]:1464 "EHLO
	imf16aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261212AbULEAru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 19:47:50 -0500
Date: Sat, 4 Dec 2004 18:47:45 -0600
From: Tommy Reynolds <Tommy.Reynolds@MegaCoder.com>
To: linux-kernel@vger.kernel.org
Subject: Re: global memory access
Message-Id: <20041204184745.4c822e39.Tommy.Reynolds@MegaCoder.com>
In-Reply-To: <Pine.GSO.4.58.0412041401570.28362@moondance.cse.ucsc.edu>
References: <20041202094433.39132.qmail@web41411.mail.yahoo.com>
	<Pine.GSO.4.58.0412041401570.28362@moondance.cse.ucsc.edu>
X-Mailer: Sylpheed version 1.0.0beta4 (GTK+ 1.2.10; i686-redhat-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$
 t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl
 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uttered Lan Xue <lanxue@soe.ucsc.edu>, spake thus:

> I was wondering how a user-level program can share a writable memory
> buffer with the kernel. The memory can either belongs to the kernel space
> or the user space, but both kernel module and user program should be able
> to access(read, write) it.

$ man 2 mmap

Cheers!

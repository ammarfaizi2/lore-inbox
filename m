Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264575AbUAYROz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 12:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264902AbUAYROz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 12:14:55 -0500
Received: from [213.92.5.19] ([213.92.5.19]:29404 "EHLO mid-2.inet.it")
	by vger.kernel.org with ESMTP id S264575AbUAYROx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 12:14:53 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Valdis.Kletnieks@vt.edu
Subject: Re: Kernels > 2.6.1-mm3 do not boot.
Date: Sun, 25 Jan 2004 18:12:41 +0100
User-Agent: KMail/1.6
Cc: Adrian Bunk <bunk@fs.tum.de>, Eric <eric@cisu.net>,
       linux-kernel@vger.kernel.org
References: <200401232253.08552.eric@cisu.net> <200401251639.56799.cova@ferrara.linux.it> <200401251628.i0PGS9Lh030629@turing-police.cc.vt.edu>
In-Reply-To: <200401251628.i0PGS9Lh030629@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200401251812.41184.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle Sunday 25 January 2004 17:28, Valdis.Kletnieks@vt.edu ha scritto:

> Does it work if you disable -funit-at-a-time?  I had a problem with that
> totally wedging a kernel right after the decompressing/loading messages.

Yep, the patch posted by Adrian removed -funit-at-a-time and now it works, 
thanks.

-- 
Fabio Coatti       http://www.ferrara.linux.it/members/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.

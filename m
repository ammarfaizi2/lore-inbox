Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265284AbUAYVXc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 16:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265287AbUAYVXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 16:23:32 -0500
Received: from mid-1.inet.it ([213.92.5.18]:8876 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S265284AbUAYVXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 16:23:31 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Date: Sun, 25 Jan 2004 22:21:01 +0100
User-Agent: KMail/1.6
Cc: Andi Kleen <ak@muc.de>, bunk@fs.tum.de, eric@cisu.net,
       linux-kernel@vger.kernel.org
References: <200401232253.08552.eric@cisu.net> <20040125174837.GB16962@colin2.muc.de> <20040125131153.16bb662b.akpm@osdl.org>
In-Reply-To: <20040125131153.16bb662b.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401252221.01679.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle Sunday 25 January 2004 22:11, Andrew Morton ha scritto:

> >
> > I disagree with that change.
>
> Well there doesn't seem much doubt that -funit-at-a-time causes Fabio's
> kernel to fail.  Do we know exactly which compiler he is using?

Well,  I'm using gcc (GCC) 3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk), provided 
with Mandrake 9.2. If more details about configuration are needed please let 
me know.


-- 
Fabio Coatti       http://www.ferrara.linux.it/members/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.

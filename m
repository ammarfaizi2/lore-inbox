Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265279AbUAYWKv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 17:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265287AbUAYWKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 17:10:51 -0500
Received: from mid-1.inet.it ([213.92.5.18]:28342 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S265279AbUAYWKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 17:10:41 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Andi Kleen <ak@muc.de>
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Date: Sun, 25 Jan 2004 23:08:33 +0100
User-Agent: KMail/1.6
Cc: Andrew Morton <akpm@osdl.org>, bunk@fs.tum.de, eric@cisu.net,
       linux-kernel@vger.kernel.org
References: <200401232253.08552.eric@cisu.net> <200401252221.01679.cova@ferrara.linux.it> <20040125214653.GB28576@colin2.muc.de>
In-Reply-To: <20040125214653.GB28576@colin2.muc.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401252308.33005.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle Sunday 25 January 2004 22:46, Andi Kleen ha scritto:

>
> what kernel version are you running exactly?

I've tried all -mm versions for 2.6.1 and 2.6.2-rc1
The latest working one without any patch was 2.6.1-mm3
2.6.2-rc1-mm3 didn't work.

> what oops are you seeing?

no oops at all. The boot stops right after "Uncompressing.." line

> does official 2.6.2rc1 (not mm) with -funit-at-a-time enabled in the
> Makefile work?

Yes. 

-- 
Fabio Coatti       http://www.ferrara.linux.it/members/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbUCAAhy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 19:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbUCAAhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 19:37:54 -0500
Received: from hal-4.inet.it ([213.92.5.23]:42441 "EHLO hal-4.inet.it")
	by vger.kernel.org with ESMTP id S262192AbUCAAhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 19:37:53 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.3-mm1 and aic7xxx
Date: Mon, 1 Mar 2004 01:37:28 +0100
User-Agent: KMail/1.6
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org
References: <A6974D8E5F98D511BB910002A50A6647615F2BAD@hdsmsx402.hd.intel.com> <200403010030.27481.cova@ferrara.linux.it> <20040229154243.64d55be9.akpm@osdl.org>
In-Reply-To: <20040229154243.64d55be9.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200403010137.28854.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 00:42, lunedì 1 marzo 2004, Andrew Morton ha scritto:

>
> If you have the time, please test 2.6.4-rc1 and then test 2.6.4-rc1
> plus
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4-rc1/2.6
>.4-rc1-mm1/broken-out/bk-acpi.patch

Done:
2.6.4-rc1 works, and the same holds for 2.6.4-rc1 with bk-acpi.patch applied.
2.6.4-rc1-mm1 hangs.


-- 
Fabio Coatti       http://www.ferrara.linux.it/members/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbUCAAjk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 19:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbUCAAjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 19:39:40 -0500
Received: from mid-1.inet.it ([213.92.5.18]:1535 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S262198AbUCAAjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 19:39:37 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: "Brown, Len" <len.brown@intel.com>
Subject: Re: 2.6.3-mm1 and aic7xxx
Date: Mon, 1 Mar 2004 01:39:28 +0100
User-Agent: KMail/1.6
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
References: <BF1FE1855350A0479097B3A0D2A80EE0028B41D7@hdsmsx402.hd.intel.com>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0028B41D7@hdsmsx402.hd.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200403010139.28956.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 00:45, lunedì 1 marzo 2004, Brown, Len ha scritto:

> To verify with the latest software, please apply the latest ACPI patch
> to 2.6.4-rc1:
>
> http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/
> 2.6.4/acpi-20040220-2.6.4.diff.gz
>
> If it works, then something else in -mm is causing your problem.  If it
> fails, then something in the latest ACPI patch (which is included in
> -mm1) is causing the failure.

Tried, and with the patch all works just fine. So it can be something else, 
applied in -mm tree after 2.6.3-rc3-mm1, tha causes the failure; i'll try to 
have a look at changes, trying to find which one causes the problem.


-- 
Fabio Coatti       http://www.ferrara.linux.it/members/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.

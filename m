Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbUB2XbE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 18:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUB2XbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 18:31:04 -0500
Received: from hal-4.inet.it ([213.92.5.23]:20637 "EHLO hal-4.inet.it")
	by vger.kernel.org with ESMTP id S262175AbUB2XbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 18:31:01 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Len Brown <len.brown@intel.com>
Subject: Re: 2.6.3-mm1 and aic7xxx
Date: Mon, 1 Mar 2004 00:30:27 +0100
User-Agent: KMail/1.6
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <A6974D8E5F98D511BB910002A50A6647615F2BAD@hdsmsx402.hd.intel.com> <1077521296.12675.81.camel@dhcppc4>
In-Reply-To: <1077521296.12675.81.camel@dhcppc4>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200403010030.27481.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 08:28, lunedì 23 febbraio 2004, Len Brown ha scritto:

>
> Fabio,
> Any chance you can isolate further where this broke by finding the
> latest release where it worked properly?
>
> ie. does vanilla 2.6.3 work if you back out the mm patch?

I don't know if this come late (I've been quite busy) anyway I've found that 
vanilla 2.6.3 and 2.6.2 works just fine; mmX versions hangs (mm1, mm2, etc..)
The latest working mm version is 2.6.3-rc3-mm1
I've also tried 2.6.4-rc1 and 2.6.4-rc1-mm1: 2.6.4-rc1 boots and works, -mm1 
hang at the very same point.

> If 2.6.3 works, then I'd be interested if the following 2.6.3 patch
> breaks it:
>http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.3/acpi-20040116-2.6.3.diff.gz

Sorry, but I can't find this patch, maybe it's outdated; if you can give me a 
new link, I'll try asap.

HTH

-- 
Fabio Coatti       http://www.ferrara.linux.it/members/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.

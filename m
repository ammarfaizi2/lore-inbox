Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266754AbUBMGPt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 01:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266771AbUBMGPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 01:15:49 -0500
Received: from hera.kernel.org ([63.209.29.2]:14479 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S266754AbUBMGPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 01:15:48 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: IPV4 as module?
Date: Fri, 13 Feb 2004 06:15:38 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c0hq2a$ftg$1@terminus.zytor.com>
References: <20040204200610.GB3802@localhost.localdomain> <20040205122921.GB28571@lug-owl.de> <Pine.LNX.4.58L.0402080257060.29247@rudy.mif.pg.gda.pl> <20040208212757.GW28571@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Trace: terminus.zytor.com 1076652938 16305 63.209.29.3 (13 Feb 2004 06:15:38 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 13 Feb 2004 06:15:38 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040208212757.GW28571@lug-owl.de>
By author:    Jan-Benedict Glaw <jbglaw@lug-owl.de>
In newsgroup: linux.dev.kernel
> 
> That's not all correct. You can fit 700 MB data on a CD-ROM, but booting
> is still emulated from a 1.44 MB floppy (or some other floppy/HDD
> images, but many BIOSses won't accept those (or handle them correctly)).
> 

Baloney.  Most BIOSes support "no emulation" booting these days; in fact,
there are more that don't do floppy emulation correctly than the few very
old BIOSes which didn't do no emulation.

	-hpa
-- 
PGP public key available - finger hpa@zytor.com
Key fingerprint: 2047/2A960705 BA 03 D3 2C 14 A8 A8 BD  1E DF FE 69 EE 35 BD 74
"The earth is but one country, and mankind its citizens."  --  Bahá'u'lláh
Just Say No to Morden * The Shadows were defeated -- Babylon 5 is renewed!!

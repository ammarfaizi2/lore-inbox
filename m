Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264360AbTLKGn7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 01:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264362AbTLKGn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 01:43:59 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60425 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264360AbTLKGn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 01:43:57 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: very large FAT16 partition not readable on 2.6.0-test11
Date: 10 Dec 2003 22:43:32 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <br93mk$5oa$1@cesium.transmeta.com>
References: <3FD65CCA.3000408@triphoenix.de> <NDBBLFLJADKDMBPPNBALOEDBCLAB.kkrieser@lcisp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <NDBBLFLJADKDMBPPNBALOEDBCLAB.kkrieser@lcisp.com>
By author:    "Kevin Krieser" <kkrieser@lcisp.com>
In newsgroup: linux.dev.kernel
>
> Actually, there is an extension to 4GB that NT used in the 4.0 days (maybe
> earlier?).
> 

One can do that with a 64K cluster size.  This is against the
currently published spec, but was apparently done sometimes.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64

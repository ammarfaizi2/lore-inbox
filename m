Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262340AbVCDGeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbVCDGeu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 01:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVCDGeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 01:34:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33509 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262453AbVCDGeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 01:34:16 -0500
Message-ID: <42280157.9040103@pobox.com>
Date: Fri, 04 Mar 2005 01:33:59 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: chrisw@osdl.org, olof@austin.ibm.com, paulus@samba.org, rene@exactcode.de,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH] trivial fix for 2.6.11 raid6 compilation on ppc w/ Altivec
References: <422751D9.2060603@exactcode.de>	<422756DC.6000405@pobox.com>	<16935.36862.137151.499468@cargo.ozlabs.ibm.com>	<20050303225542.GB16886@austin.ibm.com>	<20050303175951.41cda7a4.akpm@osdl.org>	<20050304022424.GA26769@austin.ibm.com>	<20050304055451.GN5389@shell0.pdx.osdl.net>	<4227FADD.30905@pobox.com> <20050303221745.6a7ebfea.akpm@osdl.org>
In-Reply-To: <20050303221745.6a7ebfea.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> That works as long as I don't have non-linux_release patches which depend
> upon earlier fixes.  If that happens I have to wait until linux-release
> merges up.

Hopefully linux-release pulls, and linux-release releases, will happen 
fairly quickly.  Otherwise its value diminishes.

Release early, release often </chant>

	Jeff



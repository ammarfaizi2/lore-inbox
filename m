Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbVCFXV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVCFXV0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 18:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVCFXS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 18:18:57 -0500
Received: from [81.2.110.250] ([81.2.110.250]:486 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261601AbVCFXIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 18:08:38 -0500
Subject: Re: [PATCH] trivial fix for 2.6.11 raid6 compilation on ppc w/
	Altivec
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, dtor_core@ameritech.net,
       Chris Wright <chrisw@osdl.org>, jgarzik@pobox.com, olof@austin.ibm.com,
       paulus@samba.org, rene@exactcode.de, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050304162755.GA28179@kroah.com>
References: <422756DC.6000405@pobox.com>
	 <16935.36862.137151.499468@cargo.ozlabs.ibm.com>
	 <20050303225542.GB16886@austin.ibm.com>
	 <20050303175951.41cda7a4.akpm@osdl.org>
	 <20050304022424.GA26769@austin.ibm.com>
	 <20050304055451.GN5389@shell0.pdx.osdl.net>
	 <20050303220631.79a4be7b.akpm@osdl.org> <4227FC5C.60707@pobox.com>
	 <20050304062016.GO5389@shell0.pdx.osdl.net>
	 <20050303222335.372d1ad2.akpm@osdl.org>  <20050304162755.GA28179@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110150380.28860.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 06 Mar 2005 23:06:21 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-03-04 at 16:27, Greg KH wrote:
> Ok, based on consensus, I've applied this one too.
> 
> Yes, we will get a bk-stable-commits tree up and running, still working
> out the infrastructure...

Cool. Once you've done so make sure there are also no bk snapshots and
I'll push you some of the tiny but critical fixes (security, non working
ULI tulip etc) from 11-ac1 when I upload it.

Alan


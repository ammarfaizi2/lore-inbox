Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVCGSFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVCGSFS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 13:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVCGSFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 13:05:18 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:46827 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261200AbVCGSFO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 13:05:14 -0500
Subject: Re: [PATCH] trivial fix for 2.6.11 raid6 compilation on ppc w/
	Altivec
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, dtor_core@ameritech.net,
       Chris Wright <chrisw@osdl.org>, jgarzik@pobox.com, olof@austin.ibm.com,
       paulus@samba.org, rene@exactcode.de, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1110150380.28860.6.camel@localhost.localdomain>
References: <422756DC.6000405@pobox.com>
	 <16935.36862.137151.499468@cargo.ozlabs.ibm.com>
	 <20050303225542.GB16886@austin.ibm.com>
	 <20050303175951.41cda7a4.akpm@osdl.org>
	 <20050304022424.GA26769@austin.ibm.com>
	 <20050304055451.GN5389@shell0.pdx.osdl.net>
	 <20050303220631.79a4be7b.akpm@osdl.org> <4227FC5C.60707@pobox.com>
	 <20050304062016.GO5389@shell0.pdx.osdl.net>
	 <20050303222335.372d1ad2.akpm@osdl.org>  <20050304162755.GA28179@kroah.com>
	 <1110150380.28860.6.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110218588.3072.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 07 Mar 2005 18:03:09 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-03-06 at 23:06, Alan Cox wrote:
> Cool. Once you've done so make sure there are also no bk snapshots and

That should have read "non bk" snapshots before Larry goes boom 8)



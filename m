Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266572AbUBRB7U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 20:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267017AbUBRB7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 20:59:20 -0500
Received: from palrel10.hp.com ([156.153.255.245]:23266 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S266572AbUBRB7S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 20:59:18 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16434.50928.682219.187846@napali.hpl.hp.com>
Date: Tue, 17 Feb 2004 17:59:12 -0800
To: Matthew Wilcox <willy@debian.org>
Cc: davidm@hpl.hp.com, torvalds@osdl.org, Michel D?nzer <michel@daenzer.net>,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: radeon warning on 64-bit platforms
In-Reply-To: <20040218015423.GH11824@parcelfarce.linux.theplanet.co.uk>
References: <16434.35199.597235.894615@napali.hpl.hp.com>
	<1077054385.2714.72.camel@thor.asgaard.local>
	<16434.36137.623311.751484@napali.hpl.hp.com>
	<1077055209.2712.80.camel@thor.asgaard.local>
	<16434.37025.840577.826949@napali.hpl.hp.com>
	<1077058106.2713.88.camel@thor.asgaard.local>
	<16434.41884.249541.156083@napali.hpl.hp.com>
	<20040217234848.GB22534@krispykreme>
	<16434.46860.429861.157242@napali.hpl.hp.com>
	<20040218015423.GH11824@parcelfarce.linux.theplanet.co.uk>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 18 Feb 2004 01:54:23 +0000, Matthew Wilcox <willy@debian.org> said:

  >> I don't really see the point of that, given that pretty much all
  >> existing Linux source code is formatted for 100 columns.  I don't feel
  >> strongly about it, however, so I changed it.

  Matthew> Um, only your crap.  Everybody else follows
  Matthew> Documentation/CodingStyle.

Wow.  Revisionists at work? ;-)

I personally would be more than happy to reformat things to 80 cols,
but it's a waste of time unless almost all Linux code gets
reformatted.

	--david
